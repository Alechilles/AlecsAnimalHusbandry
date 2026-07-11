param(
    [Parameter(Mandatory = $true)]
    [string]$Version,
    [string]$ConfigPath = ".release/publish-config.json"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-NormalizedVersion {
    param([string]$RawVersion)

    $trimmed = $RawVersion.Trim()
    if ([string]::IsNullOrWhiteSpace($trimmed)) {
        throw "Version cannot be empty."
    }

    return ($trimmed -replace "^v", "")
}

function Get-SourceVersion {
    param([object]$Config)

    switch ($Config.versionSource) {
        "pom" {
            [xml]$pom = Get-Content -Path $Config.versionFile
            $pomVersion = $pom.project.version
            if ([string]::IsNullOrWhiteSpace($pomVersion)) {
                throw "Unable to read <version> from '$($Config.versionFile)'."
            }

            return $pomVersion.Trim()
        }
        "manifest" {
            $manifest = Get-Content -Path $Config.versionFile -Raw | ConvertFrom-Json
            if ([string]::IsNullOrWhiteSpace($manifest.Version)) {
                throw "Unable to read Version from '$($Config.versionFile)'."
            }

            return $manifest.Version.Trim()
        }
        default {
            throw "Unsupported versionSource '$($Config.versionSource)' in $ConfigPath."
        }
    }
}

function Assert-ChangelogHasVersion {
    param(
        [string]$ChangelogPath,
        [string]$NormalizedVersion
    )

    if (-not (Test-Path -Path $ChangelogPath)) {
        throw "Changelog file '$ChangelogPath' was not found."
    }

    $escapedVersion = [regex]::Escape($NormalizedVersion)
    $pattern = "(?m)^##\s+v?$escapedVersion(\s+-|\s*$)"
    $content = Get-Content -Path $ChangelogPath -Raw
    if ($content -notmatch $pattern) {
        throw "CHANGELOG.md is missing a heading for version '$NormalizedVersion'."
    }
}

function Assert-PackageInputs {
    param([object]$Config)

    switch ($Config.packaging) {
        "jar" {
            foreach ($requiredPath in @($Config.versionFile, "src/main/resources/manifest.json")) {
                if (-not (Test-Path -Path $requiredPath)) {
                    throw "Required jar input '$requiredPath' was not found."
                }
            }
        }
        "zip" {
            foreach ($path in @($Config.zipIncludes)) {
                if (-not (Test-Path -Path $path)) {
                    throw "Required zip input '$path' was not found."
                }
            }
        }
        default {
            throw "Unsupported packaging '$($Config.packaging)' in $ConfigPath."
        }
    }
}

function Get-NormalizedZipInclude {
    param([string]$Path)

    return (($Path.Trim()) -replace "\\", "/").Trim("/")
}

function Assert-ZipIncludesHaveNoAncestorConflicts {
    param([object]$ZipIncludes)

    $normalizedIncludes = @($ZipIncludes | ForEach-Object { Get-NormalizedZipInclude -Path ([string]$_) })
    for ($i = 0; $i -lt $normalizedIncludes.Count; $i++) {
        for ($j = 0; $j -lt $normalizedIncludes.Count; $j++) {
            if ($i -eq $j) {
                continue
            }

            $parent = $normalizedIncludes[$i]
            $child = $normalizedIncludes[$j]
            if ($child.StartsWith("$parent/", [StringComparison]::OrdinalIgnoreCase)) {
                throw "Zip include '$child' is nested under zip include '$parent'. Include only '$parent' to avoid nested package paths."
            }
        }
    }
}

if (-not (Test-Path -Path $ConfigPath)) {
    throw "Release config '$ConfigPath' was not found."
}

$config = Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json
$normalizedVersion = Get-NormalizedVersion -RawVersion $Version
$sourceVersion = Get-SourceVersion -Config $config

if ($sourceVersion -ne $normalizedVersion) {
    throw "Version mismatch: source '$sourceVersion' does not match requested '$normalizedVersion'."
}

Assert-ChangelogHasVersion -ChangelogPath "CHANGELOG.md" -NormalizedVersion $normalizedVersion
Assert-PackageInputs -Config $config
if ($config.packaging -eq "zip") {
    Assert-ZipIncludesHaveNoAncestorConflicts -ZipIncludes $config.zipIncludes
}

$localizationCoverageScript = Join-Path $PSScriptRoot "..\tools\check-ah-localization-coverage.ps1"
if (-not (Test-Path -LiteralPath $localizationCoverageScript)) {
    throw "Localization coverage script '$localizationCoverageScript' was not found."
}
& $localizationCoverageScript -Root (Resolve-Path ".").Path

$equipmentCoverageScript = Join-Path $PSScriptRoot "..\tools\check-ah-equipment-assets.ps1"
if (-not (Test-Path -LiteralPath $equipmentCoverageScript)) {
    throw "Equipment asset check '$equipmentCoverageScript' was not found."
}
& $equipmentCoverageScript -Root (Resolve-Path ".").Path

if ($config.requiresTameworkDependency) {
    if ($config.versionSource -ne "manifest") {
        throw "requiresTameworkDependency is only supported for manifest versionSource."
    }

    $manifest = Get-Content -Path $config.versionFile -Raw | ConvertFrom-Json
    $dependencies = $manifest.Dependencies.PSObject.Properties.Name
    if ($dependencies -notcontains "Alechilles:Alec's Tamework!") {
        throw "manifest.json is missing dependency 'Alechilles:Alec's Tamework!'."
    }

    if ($config.PSObject.Properties.Name -contains "expectedTameworkDependency") {
        $expectedTameworkDependency = [string]$config.expectedTameworkDependency
        $actualTameworkDependency = [string]$manifest.Dependencies."Alechilles:Alec's Tamework!"
        if ([string]::IsNullOrWhiteSpace($actualTameworkDependency)) {
            throw "manifest.json has an empty dependency range for 'Alechilles:Alec's Tamework!'."
        }
        if ($actualTameworkDependency.Trim() -ne $expectedTameworkDependency.Trim()) {
            throw "manifest.json Tamework dependency '$actualTameworkDependency' does not match expected '$expectedTameworkDependency'."
        }
    }
}

Write-Host "Release validation passed for $($config.modName) $normalizedVersion"
