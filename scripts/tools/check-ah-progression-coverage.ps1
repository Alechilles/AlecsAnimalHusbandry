param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..\..").Path
)

$ErrorActionPreference = "Stop"

$expectedExcludedRoles = @(
    "Tamed_Flamingo_Chick",
    "Tamed_Fox_Arctic_Cub",
    "Tamed_Fox_Cub",
    "Tamed_Hydra",
    "Tamed_NordicDrake",
    "Tamed_Tetrabird_Chick"
)

function Get-CheckedInTamedRoles {
    param([string]$Root)
    Get-ChildItem -Path (Join-Path $Root "Server/NPC/Roles") -Recurse -File -Filter "Tamed_*.json" |
        ForEach-Object { [IO.Path]::GetFileNameWithoutExtension($_.Name) } |
        Sort-Object -Unique
}

function Get-RoleScopedConfigs {
    param(
        [string]$Root,
        [string]$Family
    )
    Get-ChildItem -Path (Join-Path $Root "Server/Tamework/$Family") -File -Filter "*.json" |
        ForEach-Object {
            $json = Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json
            [pscustomobject]@{
                Id = [IO.Path]::GetFileNameWithoutExtension($_.Name)
                Priority = [int]$json.Priority
                Roles = @($json.RoleIds)
            }
        }
}

function Assert-ExactCoverage {
    param(
        [string[]]$Roles,
        [array]$Configs,
        [string]$Family
    )
    $missing = [System.Collections.Generic.List[string]]::new()
    $multi = [System.Collections.Generic.List[string]]::new()
    $winners = @{}

    foreach ($role in $Roles) {
        $matches = @($Configs | Where-Object { $_.Roles -contains $role })
        if ($matches.Count -eq 0) {
            $missing.Add($role)
            continue
        }
        if ($matches.Count -gt 1) {
            $multi.Add("$role => $($matches.Id -join ', ')")
        }
        $winner = $matches |
            Sort-Object @{ Expression = "Priority"; Descending = $true }, @{ Expression = "Id"; Descending = $false } |
            Select-Object -First 1
        $winners[$role] = $winner.Id
    }

    if ($missing.Count -gt 0) {
        throw "$Family missing roles: $($missing -join ', ')"
    }
    if ($multi.Count -gt 0) {
        throw "$Family has overlapping role coverage: $($multi -join '; ')"
    }

    $external = @($Configs | ForEach-Object { $_.Roles } | Where-Object { $expectedExcludedRoles -contains $_ } | Sort-Object -Unique)
    if ($external.Count -gt 0) {
        throw "$Family includes command allowlist placeholder/external roles: $($external -join ', ')"
    }

    Write-Host "$Family coverage: $($winners.Count) roles across $($Configs.Count) configs."
    $winners.GetEnumerator() |
        Group-Object Value |
        Sort-Object Name |
        ForEach-Object { Write-Host "  $($_.Name): $($_.Count)" }
}

$roles = @(Get-CheckedInTamedRoles -Root $Root)
if ($roles.Count -ne 93) {
    throw "Expected 93 checked-in Tamed_*.json roles, found $($roles.Count)."
}

Assert-ExactCoverage -Roles $roles -Configs (Get-RoleScopedConfigs -Root $Root -Family "Leveling") -Family "Leveling"
Assert-ExactCoverage -Roles $roles -Configs (Get-RoleScopedConfigs -Root $Root -Family "Talents") -Family "Talents"
Assert-ExactCoverage -Roles $roles -Configs (Get-RoleScopedConfigs -Root $Root -Family "Traits") -Family "Traits"
