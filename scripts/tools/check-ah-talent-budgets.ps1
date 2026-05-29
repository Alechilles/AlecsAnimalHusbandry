param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..\..").Path
)

$ErrorActionPreference = "Stop"

$configs = @(
    @{
        Name = "LivestockHarvest"
        Path = "Server/Tamework/Talents/AHTalentLivestock.json"
        MaxPoints = 24
        MinOptionCost = 36
        MaxOptionCost = 42
        Upper = @{
            MaxHealthMultiplier = 1.16
            MoveSpeedMultiplier = 1.09
            HarvestDoubleDropChanceMultiplier = 1.18
            TraitMutationChanceMultiplier = 1.80
        }
        Lower = @{
            NeedsDecayMultiplier = 0.80
            HarvestCooldownMultiplier = 0.75
            ReviveCooldownMultiplier = 0.70
        }
        ForbiddenEffects = @()
    },
    @{
        Name = "LivestockGeneral"
        Path = "Server/Tamework/Talents/AHTalentLivestockGeneral.json"
        MaxPoints = 24
        MinOptionCost = 30
        MaxOptionCost = 34
        Upper = @{
            MaxHealthMultiplier = 1.16
            MoveSpeedMultiplier = 1.09
            TraitMutationChanceMultiplier = 1.80
        }
        Lower = @{
            NeedsDecayMultiplier = 0.80
            ReviveCooldownMultiplier = 0.70
        }
        ForbiddenEffects = @("HarvestDoubleDropChanceMultiplier", "HarvestCooldownMultiplier")
    },
    @{
        Name = "Neutral"
        Path = "Server/Tamework/Talents/AHTalentNeutral.json"
        MaxPoints = 24
        MinOptionCost = 36
        MaxOptionCost = 40
        Upper = @{
            MaxHealthMultiplier = 1.16
            MoveSpeedMultiplier = 1.10
            DamageDealtMultiplier = 1.08
            TraitMutationChanceMultiplier = 1.80
        }
        Lower = @{
            NeedsDecayMultiplier = 0.80
            BreedCooldownMultiplier = 0.80
            ReviveCooldownMultiplier = 0.70
        }
        ForbiddenEffects = @("HarvestDoubleDropChanceMultiplier", "HarvestCooldownMultiplier")
    },
    @{
        Name = "Critter"
        Path = "Server/Tamework/Talents/AHTalentCritter.json"
        MaxPoints = 19
        MinOptionCost = 26
        MaxOptionCost = 32
        Upper = @{
            MaxHealthMultiplier = 1.12
            MoveSpeedMultiplier = 1.08
            TraitMutationChanceMultiplier = 1.50
        }
        Lower = @{
            NeedsDecayMultiplier = 0.80
            ReviveCooldownMultiplier = 0.75
        }
        ForbiddenEffects = @("HarvestDoubleDropChanceMultiplier", "HarvestCooldownMultiplier", "DamageDealtMultiplier")
    },
    @{
        Name = "Beast"
        Path = "Server/Tamework/Talents/AHTalentBeast.json"
        MaxPoints = 29
        MinOptionCost = 50
        MaxOptionCost = 58
        Upper = @{
            MaxHealthMultiplier = 1.22
            DamageDealtMultiplier = 1.20
            MoveSpeedMultiplier = 1.08
            TraitMutationChanceMultiplier = 1.50
        }
        Lower = @{
            NeedsDecayMultiplier = 0.85
            ReviveCooldownMultiplier = 0.60
            BreedCooldownMultiplier = 0.85
        }
        ForbiddenEffects = @("HarvestDoubleDropChanceMultiplier", "HarvestCooldownMultiplier")
    }
)

function Get-EffectProduct {
    param(
        [array]$Talents,
        [string]$EffectKey
    )
    $value = 1.0
    foreach ($talent in $Talents) {
        foreach ($effect in @($talent.Effects)) {
            if ($effect.EffectKey -eq $EffectKey) {
                $value *= [double]$effect.Multiplier
            }
        }
    }
    return $value
}

function Test-PrerequisitesMet {
    param(
        [object]$Talent,
        [string[]]$PurchasedIds
    )
    foreach ($requiredId in @($Talent.RequiresTalentIds)) {
        if ($null -eq $requiredId -or [string]::IsNullOrWhiteSpace([string]$requiredId)) {
            continue
        }
        if (-not ($PurchasedIds -contains [string]$requiredId)) {
            return $false
        }
    }
    return $true
}

function Get-LegalTalentSets {
    param(
        [array]$Talents,
        [int]$MaxPoints
    )
    $byId = @{}
    foreach ($talent in $Talents) {
        $byId[$talent.Id] = $talent
    }
    $visited = [System.Collections.Generic.HashSet[string]]::new()
    $sets = [System.Collections.Generic.List[object]]::new()

    $visit = $null
    $visit = {
        param(
            [int]$StartIndex,
            [string[]]$PurchasedIds,
            [int]$Spent
        )

        $ids = @($PurchasedIds) | Sort-Object
        $key = ($ids -join "|")
        if (-not $visited.Add($key)) {
            return
        }
        $selected = foreach ($id in $ids) { $byId[$id] }
        $sets.Add([pscustomobject]@{
            Spent = $Spent
            Talents = @($selected)
        })

        for ($i = $StartIndex; $i -lt $Talents.Count; $i++) {
            $talent = $Talents[$i]
            if ($ids -contains $talent.Id) {
                continue
            }
            $cost = [int]$talent.PointCost
            if (($Spent + $cost) -gt $MaxPoints) {
                continue
            }
            if (-not (Test-PrerequisitesMet -Talent $talent -PurchasedIds $ids)) {
                continue
            }
            $next = @($ids + $talent.Id)
            & $visit ($i + 1) $next ($Spent + $cost)
        }
    }

    & $visit 0 @() 0
    return $sets.ToArray()
}

foreach ($config in $configs) {
    $path = Join-Path $Root $config.Path
    $json = Get-Content -Raw -LiteralPath $path | ConvertFrom-Json
    $talents = @($json.Talents)
    $optionCost = ($talents | Measure-Object -Property PointCost -Sum).Sum
    if ($optionCost -le $config.MaxPoints) {
        throw "$($config.Name) option cost $optionCost must exceed earned points $($config.MaxPoints)."
    }
    if ($optionCost -lt $config.MinOptionCost -or $optionCost -gt $config.MaxOptionCost) {
        throw "$($config.Name) option cost $optionCost is outside expected range $($config.MinOptionCost)-$($config.MaxOptionCost)."
    }

    foreach ($talent in $talents) {
        $talentIndex = [array]::IndexOf($talents, $talent)
        if ([int]$talent.Tier -eq 1 -and [int]$talent.MinLevel -ne 1) {
            throw "$($config.Name) tier 1 talent $($talent.Id) must require level 1."
        }
        foreach ($requiredId in @($talent.RequiresTalentIds)) {
            if ($null -eq $requiredId -or [string]::IsNullOrWhiteSpace([string]$requiredId)) {
                continue
            }
            $requiredTalent = $talents | Where-Object { $_.Id -eq [string]$requiredId } | Select-Object -First 1
            if ($null -eq $requiredTalent) {
                throw "$($config.Name) talent $($talent.Id) requires missing talent $requiredId."
            }
            $requiredIndex = [array]::IndexOf($talents, $requiredTalent)
            if ($requiredIndex -ge $talentIndex) {
                throw "$($config.Name) talent $($talent.Id) must appear after prerequisite $requiredId."
            }
        }
        foreach ($effect in @($talent.Effects)) {
            if ($config.ForbiddenEffects -contains [string]$effect.EffectKey) {
                throw "$($config.Name) talent $($talent.Id) uses forbidden effect $($effect.EffectKey)."
            }
        }
    }

    $sets = @(Get-LegalTalentSets -Talents $talents -MaxPoints $config.MaxPoints)
    if ($sets.Count -eq 0) {
        throw "$($config.Name) has no legal talent purchase sets."
    }

    foreach ($effectKey in $config.Upper.Keys) {
        $best = ($sets | ForEach-Object { Get-EffectProduct -Talents $_.Talents -EffectKey $effectKey } | Measure-Object -Maximum).Maximum
        if ($best -gt ([double]$config.Upper[$effectKey] + 0.000001)) {
            throw "$($config.Name) $effectKey legal best $best exceeds cap $($config.Upper[$effectKey])."
        }
    }
    foreach ($effectKey in $config.Lower.Keys) {
        $best = ($sets | ForEach-Object { Get-EffectProduct -Talents $_.Talents -EffectKey $effectKey } | Measure-Object -Minimum).Minimum
        if ($best -lt ([double]$config.Lower[$effectKey] - 0.000001)) {
            throw "$($config.Name) $effectKey legal best $best is below floor $($config.Lower[$effectKey])."
        }
    }

    Write-Host "$($config.Name): $($talents.Count) nodes, $optionCost option cost, $($config.MaxPoints) earned points, $($sets.Count) legal purchase states."
}
