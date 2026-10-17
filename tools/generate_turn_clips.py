"""Builds TurnLeft / TurnRight clips from a species' own Walk clip, following the vanilla Cow and Pig
turn clips: the feet keep stepping in place (limb-root swing shrunk toward its average pose, lower
segments untouched so the feet still lift), the spine curves into the turn (pelvis against it, chest and
neck with it, head leading) and the tail trails. Right is the same clip with the yaw reversed.

Usage: gen_turn.py WALK_CLIP MODEL OUT_DIR   (paths are Common-relative or local files)
"""
import json, math, os, sys, copy, zipfile
import numpy as np
sys.path.insert(0, os.path.join(os.path.expanduser("~"), ".claude", "skills", "hytale-style-guide", "scripts"))
from hyrender import Clip, collect_faces  # noqa: E402

AH = r"C:\Users\22ale\AppData\Roaming\Hytale\Modding\Alec's Animal Husbandry!"
_Z = None


def read_common(p):
    if os.path.exists(p):
        return json.load(open(p, encoding="utf-8-sig"))
    lp = os.path.join(AH, "Common", p.replace("/", os.sep))
    if os.path.exists(lp):
        return json.load(open(lp, encoding="utf-8-sig"))
    global _Z
    _Z = _Z or zipfile.ZipFile(os.path.expandvars(r"%APPDATA%\Hytale\install\release\package\game\latest\Assets.zip"))
    return json.loads(_Z.read("Common/" + p).decode("utf-8-sig"))


# ---- quaternions (x, y, z, w)
def qmul(a, b):
    ax, ay, az, aw = a; bx, by, bz, bw = b
    return np.array([aw*bx + ax*bw + ay*bz - az*by, aw*by - ax*bz + ay*bw + az*bx,
                     aw*bz + ax*by - ay*bx + az*bw, aw*bw - ax*bx - ay*by - az*bz])


def qconj(q):
    return np.array([-q[0], -q[1], -q[2], q[3]])


def qrot(q, v):
    return qmul(qmul(q, np.array([v[0], v[1], v[2], 0.0])), qconj(q))[:3]


def qaxis(axis, deg):
    axis = np.asarray(axis, float); axis = axis / np.linalg.norm(axis)
    h = math.radians(deg) / 2
    return np.array([*(axis * math.sin(h)), math.cos(h)])


def qnorm(q):
    return q / np.linalg.norm(q)


def slerp(a, b, t):
    a, b = qnorm(a), qnorm(b)
    d = float(np.dot(a, b))
    if d < 0:
        b, d = -b, -d
    if d > 0.9995:
        return qnorm(a + (b - a) * t)
    th = math.acos(d)
    return (math.sin((1 - t) * th) * a + math.sin(t * th) * b) / math.sin(th)


def qmean(qs):
    ref = qnorm(np.array(qs[0], float)); acc = np.zeros(4)
    for q in qs:
        q = np.array(q, float)
        acc += q if np.dot(q, ref) >= 0 else -q
    return qnorm(acc)


def qd(d):
    return np.array([d["x"], d["y"], d["z"], d["w"]], float)


def dq(q):
    q = qnorm(q)
    if q[3] < 0:
        q = -q
    return {k: (0 if abs(v) < 1e-7 else round(float(v), 6)) for k, v in zip("xyzw", q)}


# ---- rig
SIDE = ("L-", "R-")
NOT_LIMB = ("Eye", "Ear", "Brow", "Lid", "Horn", "Antenna", "Mandible", "Whisk", "Nipple", "Cheek", "Nostril", "Fang",
            "Tusk", "Attachment", "Hair", "Fur", "Feather", "Puff")


def index_model(model):
    """name -> dict(parent, bind (quat), children) for the first node of each name."""
    nodes = {}

    def walk(n, parent):
        nm = n.get("name", "")
        o = n.get("orientation") or {}
        if nm not in nodes:
            nodes[nm] = {"parent": parent, "bind": np.array([o.get("x", 0), o.get("y", 0), o.get("z", 0), o.get("w", 1)], float),
                         "children": [c.get("name", "") for c in n.get("children") or []]}
        for c in n.get("children") or []:
            walk(c, nm)
    for n in model["nodes"]:
        walk(n, None)
    return nodes


def bind_world(nodes, name):
    chain = []
    while name is not None:
        chain.append(name); name = nodes[name]["parent"]
    q = np.array([0, 0, 0, 1.0])
    for nm in reversed(chain):
        q = qmul(q, nodes[nm]["bind"])
    return q


def ancestors(nodes, name):
    out = []
    p = nodes[name]["parent"]
    while p is not None:
        out.append(p); p = nodes[p]["parent"]
    return out


def rest_world_pos(model):
    """name -> world position of the node's pivot in the bind pose."""
    out = {}

    def walk(n, pq, pp):
        p = n.get("position") or {}; o = n.get("orientation") or {}
        pos = np.array([p.get("x", 0), p.get("y", 0), p.get("z", 0)], float)
        wp = pp + qrot(pq, pos)
        q = qmul(pq, np.array([o.get("x", 0), o.get("y", 0), o.get("z", 0), o.get("w", 1)], float))
        out.setdefault(n.get("name", ""), wp)
        for c in n.get("children") or []:
            walk(c, q, wp)
    for n in model["nodes"]:
        walk(n, np.array([0, 0, 0, 1.0]), np.zeros(3))
    return out


def subtree(nodes, name):
    out, seen = [], set()
    stack = [name]
    while stack:
        n = stack.pop()
        if n in seen or n not in nodes:
            continue
        seen.add(n); out.append(n); stack.extend(nodes[n]["children"])
    return out


def lift_time(anims, nodes, root, dur):
    """Frame where the limb is lifted: its lower segment folds most, or its pivot rises highest."""
    kids = [c for c in nodes[root]["children"] if c in anims and (anims[c].get("orientation") or [])]
    if kids:
        ks = anims[kids[0]]["orientation"]
        mean = qmean([qd(k["delta"]) for k in ks])
        best = max(ks, key=lambda k: 1 - abs(float(np.dot(qnorm(qd(k["delta"])), mean))))
        return best["time"]
    pk = (anims.get(root) or {}).get("position") or []
    if pk:
        return max(pk, key=lambda k: k["delta"]["y"])["time"]
    return None


def lowest(model, clip, t):
    ys = []
    for f in collect_faces(model, clip.pose(t)):
        o, u, v = f["o"], f["u"], f["v"]
        ys += [o[1], (o + u)[1], (o + v)[1], (o + u + v)[1]]
    return min(ys) if ys else 0.0


def ground_fix(doc, walk, model, root):
    """Raise or lower `root` per sample so the turn's lowest point matches the walk's (planted feet)."""
    dur = doc.get("duration", 1)
    cw, ct = Clip(walk), Clip(doc)
    times = sorted({int(round(dur * i / 8)) % dur for i in range(8)})
    ch = doc["nodeAnimations"].setdefault(root, {})
    for c in ("orientation", "position", "shapeStretch", "shapeVisible", "shapeUvOffset"):
        ch.setdefault(c, [])
    old = ch["position"]
    fixes = []
    keys = []
    for t in times:
        d = lowest(model, cw, t) - lowest(model, ct, t)
        fixes.append(d)
        base = ct._sample(old, t, "v") if old else (0, 0, 0)
        keys.append({"time": t, "delta": {"x": round(base[0], 6), "y": round(base[1] + d, 6), "z": round(base[2], 6)},
                     "interpolationType": "smooth"})
    if max(abs(x) for x in fixes) > 0.05:
        ch["position"] = keys
    return max(fixes) if fixes else 0.0


def is_root_handle(nodes, name):
    """A bare top node (Origin, Root) that only carries the body; a top-level Pelvis is part of the spine."""
    return nodes[name]["parent"] is None and name in ("Origin", "Root")


def find_head(nodes):
    for want in ("Head",):
        if want in nodes:
            return want
    for nm in nodes:
        if "Head" in nm and not nm.startswith(SIDE):
            return nm
    return None


def spine_offsets(nodes, head, lean):
    """Incremental yaw (degrees, turning left) per spine node, root to head."""
    chain = [head] + ancestors(nodes, head)
    chain = [n for n in reversed(chain) if not is_root_handle(nodes, n)]
    # chain: first node under the root (usually Pelvis) ... Head
    offs = {}
    if not chain:
        return offs
    if len(chain) == 1:
        offs[chain[0]] = 12 * lean
        return offs
    offs[chain[0]] = -6 * lean
    offs[chain[-1]] = 8 * lean
    middle = chain[1:-1]
    if middle:
        for n in middle:
            offs[n] = 14.0 * lean / len(middle)
    else:
        offs[chain[-1]] += 6 * lean
    # tail chains hanging off the first spine node trail against the turn
    root = chain[0]
    for c in nodes[root]["children"]:
        if c.startswith("Tail") or c.startswith("Rear") or c.startswith("Abdomen"):
            seg = c; depth = 0
            while seg is not None and depth < 10:
                offs[seg] = offs.get(seg, 0) - 2.5 * lean
                kids = [k for k in nodes[seg]["children"] if k.startswith(("Tail", "Abdomen", "Rear"))]
                seg = kids[0] if kids else None; depth += 1
    return offs


def limb_roots(nodes):
    out = []
    for nm, n in nodes.items():
        p = n["parent"]
        if nm.startswith(SIDE) and p is not None and not p.startswith(SIDE) and not any(s in nm for s in NOT_LIMB):
            out.append(nm)
    return out


ROLL = 12.0


def build(walk, model, lean, swing=0.25):
    nodes = index_model(model)
    doc = copy.deepcopy(walk)
    anims = doc.setdefault("nodeAnimations", {})
    # 1. step in place: shrink each limb root's swing toward its average pose
    for nm in limb_roots(nodes):
        ch = anims.get(nm) or {}
        ks = ch.get("orientation") or []
        if len(ks) >= 2:
            mean = qmean([qd(k["delta"]) for k in ks])
            for k in ks:
                k["delta"] = dq(slerp(mean, qd(k["delta"]), swing))
        pk = ch.get("position") or []
        if len(pk) >= 2:
            # keep the lift (y), shrink the fore-aft travel (z)
            mz = sum(k["delta"]["z"] for k in pk) / len(pk)
            for k in pk:
                k["delta"]["z"] = round(mz + (k["delta"]["z"] - mz) * swing, 6)
    # 1b. step sideways while lifted: front feet reach into the turn, hind feet swing out
    dur = doc.get("duration", 1)
    clip = Clip(doc)
    rest = rest_world_pos(model)
    pelvis = rest.get("Pelvis", np.zeros(3))
    for nm in limb_roots(nodes):
        if any("Wing" in d for d in subtree(nodes, nm)):
            continue
        tl = lift_time(anims, nodes, nm, dur)
        if tl is None:
            continue
        dz = rest.get(nm, pelvis)[2] - pelvis[2]
        front = 1 if dz > 2 else (-1 if dz < -2 else 0)
        amp = ROLL * lean * (front if front else 0.5)
        if amp == 0:
            continue
        ch = anims.setdefault(nm, {})
        old = ch.get("orientation") or []
        times = sorted({k["time"] for k in old} | {int(round(tl + dur * f)) % dur for f in (0, 0.25, 0.5, 0.75)})
        pb = bind_world(nodes, nm)
        fwd_local = qrot(qconj(pb), (0, 0, 1))
        keys = []
        for t in times:
            base = clip._sample(old, t, "q") if old else (0, 0, 0, 1)
            bump = max(0.0, math.cos(2 * math.pi * (t - tl) / dur))
            keys.append({"time": t, "delta": dq(qmul(qaxis(fwd_local, amp * bump), np.array(base, float))),
                         "interpolationType": "smooth"})
        ch["orientation"] = keys
        for c in ("position", "shapeStretch", "shapeVisible", "shapeUvOffset"):
            ch.setdefault(c, [])
    # 2. curve the spine into the turn, about each node's own up axis
    head = find_head(nodes)
    offs = spine_offsets(nodes, head, lean) if head else {}
    for nm, deg in offs.items():
        if abs(deg) < 1e-6 or nm not in nodes:
            continue
        pb = bind_world(nodes, nm)
        up_local = qrot(qconj(pb), (0, 1, 0))
        r = qaxis(up_local, deg)
        ch = anims.setdefault(nm, {})
        ks = ch.get("orientation") or []
        if ks:
            for k in ks:
                k["delta"] = dq(qmul(r, qd(k["delta"])))
        else:
            ch["orientation"] = [{"time": 0, "delta": dq(r), "interpolationType": "smooth"}]
        for c in ("position", "shapeStretch", "shapeVisible", "shapeUvOffset"):
            ch.setdefault(c, [])
    spine_root = None
    if head:
        chain = [head] + ancestors(nodes, head)
        chain = [n for n in reversed(chain) if not is_root_handle(nodes, n)]
        spine_root = chain[0] if chain else None
    if spine_root:
        ground_fix(doc, walk, model, spine_root)
    return doc, sorted(offs.items()), limb_roots(nodes)


def main():
    walk_p, model_p, out_dir = sys.argv[1:4]
    walk = read_common(walk_p); model = read_common(model_p)
    os.makedirs(out_dir, exist_ok=True)
    for name, lean in (("Turn_Left", 1), ("Turn_Right", -1)):
        doc, offs, limbs = build(walk, model, lean)
        with open(os.path.join(out_dir, name + ".blockyanim"), "w", encoding="utf-8", newline="\n") as f:
            json.dump(doc, f, indent=2)
            f.write("\n")
    print("limbs:", ",".join(limbs))
    print("spine:", ", ".join("%s %+.1f" % (n, d) for n, d in offs))


if __name__ == "__main__":
    main()
