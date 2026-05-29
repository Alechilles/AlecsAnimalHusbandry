param(
    [string] $Root = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

$roles = @(
    "Server/NPC/Roles/Creature/Mammal/Wolf_Black.json",
    "Server/NPC/Roles/Creature/Mammal/Wolf_White.json",
    "Server/NPC/Roles/Creature/Mammal/Tamed/Tamed_Wolf_Black.json",
    "Server/NPC/Roles/Creature/Mammal/Tamed/Tamed_Wolf_White.json"
)

$stagingRoles = @(
    "artifacts/staging/Server/NPC/Roles/Creature/Mammal/Wolf_Black.json",
    "artifacts/staging/Server/NPC/Roles/Creature/Mammal/Wolf_White.json",
    "artifacts/staging/Server/NPC/Roles/Creature/Mammal/Tamed/Tamed_Wolf_Black.json",
    "artifacts/staging/Server/NPC/Roles/Creature/Mammal/Tamed/Tamed_Wolf_White.json"
)

$rolesToCheck = New-Object System.Collections.Generic.List[string]
$roles | ForEach-Object { $rolesToCheck.Add($_) }
$stagingRoles | ForEach-Object {
    if (Test-Path -LiteralPath (Join-Path $Root $_)) {
        $rolesToCheck.Add($_)
    }
}

$failures = New-Object System.Collections.Generic.List[string]

foreach ($role in $rolesToCheck) {
    $path = Join-Path $Root $role
    if (-not (Test-Path -LiteralPath $path)) {
        $failures.Add("${role}: missing role file")
        continue
    }

    $json = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
    $modify = $json.Modify
    if ($null -eq $modify) {
        $failures.Add("${role}: missing Modify block")
        continue
    }

    if ($modify.CombatBehaviorDistance -ne 8) {
        $failures.Add("${role}: CombatBehaviorDistance must be 8 so the wolf has room to re-enter combat movement after backing off")
    }
    if ($modify.CombatDirectWeight -ne 0) {
        $failures.Add("${role}: CombatDirectWeight must be 0 so wolves do not mix direct close-in behavior with strafing")
    }
    if ($modify.CombatStrafeWeight -ne 10) {
        $failures.Add("${role}: CombatStrafeWeight must be 10")
    }
    if ($modify.CombatBackOffAfterAttack -ne $true) {
        $failures.Add("${role}: CombatBackOffAfterAttack must stay enabled")
    }

    $distance = @($modify.CombatBackOffDistanceRange)
    if ($distance.Count -ne 2 -or $distance[0] -ne 3 -or $distance[1] -ne 5) {
        $failures.Add("${role}: CombatBackOffDistanceRange must preserve the original [3, 5] wolf retreat")
    }

    if ($null -ne $modify.CombatBackOffDurationRange) {
        $duration = @($modify.CombatBackOffDurationRange)
        if ($duration.Count -ne 2 -or $duration[0] -ne 2 -or $duration[1] -ne 3) {
            $failures.Add("${role}: explicit CombatBackOffDurationRange must preserve the original [2, 3] timing")
        }
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { [Console]::Error.WriteLine($_) }
    exit 1
}

Write-Host "Wolf combat spacing checks passed."
