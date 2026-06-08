param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..\..").Path
)

$ErrorActionPreference = "Stop"

$requiredLanguages = @("en-US", "de-DE", "fr-FR", "fr-CA", "pt-BR")
$playerFacingFields = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
@(
    "Name",
    "Description",
    "RoleDisplayName",
    "DisplayName",
    "HudMessage",
    "ChatMessage",
    "Message",
    "CommandFeedback",
    "Tooltip",
    "Label",
    "Branch",
    "Prompt",
    "Title",
    "Text"
) | ForEach-Object { [void]$playerFacingFields.Add($_) }

$requiredTameworkKeyFields = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
@(
    "Description",
    "RoleDisplayName",
    "DisplayName",
    "HudMessage",
    "ChatMessage",
    "Message",
    "CommandFeedback",
    "Tooltip",
    "Label",
    "Branch",
    "Prompt",
    "Title",
    "Text"
) | ForEach-Object { [void]$requiredTameworkKeyFields.Add($_) }

function Normalize-LanguageKey {
    param([string]$Value)

    return (([string]$Value).Trim() -replace "^server\.", "")
}

function Test-LanguageKeyShape {
    param([string]$Value)

    return ([string]$Value).Trim() -match "^(server\.)?[A-Za-z0-9_]+(\.[A-Za-z0-9_]+)+$"
}

function Read-LanguageKeys {
    param([string]$Path)

    $keys = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    foreach ($line in Get-Content -LiteralPath $Path) {
        $trimmed = $line.Trim()
        if ([string]::IsNullOrWhiteSpace($trimmed) -or $trimmed.StartsWith("#")) {
            continue
        }
        $separator = $trimmed.IndexOf("=")
        if ($separator -le 0) {
            continue
        }
        [void]$keys.Add((Normalize-LanguageKey -Value $trimmed.Substring(0, $separator)))
    }

    return ,$keys
}

$keyReferences = [System.Collections.Generic.List[object]]::new()
$rawTameworkText = [System.Collections.Generic.List[object]]::new()

function Add-JsonLocalizationReferences {
    param(
        [object]$Node,
        [string]$JsonPath,
        [string]$RelativePath,
        [bool]$IsTameworkConfig
    )

    if ($null -eq $Node) {
        return
    }

    if ($Node -is [System.Array]) {
        for ($index = 0; $index -lt $Node.Count; $index++) {
            Add-JsonLocalizationReferences -Node $Node[$index] -JsonPath "$JsonPath[$index]" -RelativePath $RelativePath -IsTameworkConfig $IsTameworkConfig
        }
        return
    }

    if ($Node -is [System.Management.Automation.PSCustomObject]) {
        foreach ($property in $Node.PSObject.Properties) {
            $field = $property.Name
            $value = $property.Value
            $childPath = "$JsonPath.$field"

            if (($value -is [string]) -and $playerFacingFields.Contains($field)) {
                $trimmedValue = $value.Trim()
                if (Test-LanguageKeyShape -Value $trimmedValue) {
                    $keyReferences.Add([pscustomobject]@{
                        Key = Normalize-LanguageKey -Value $trimmedValue
                        File = $RelativePath
                        Path = $childPath
                        Field = $field
                    })
                } elseif ($IsTameworkConfig -and $requiredTameworkKeyFields.Contains($field) -and -not [string]::IsNullOrWhiteSpace($trimmedValue)) {
                    $rawTameworkText.Add([pscustomobject]@{
                        Value = $trimmedValue
                        File = $RelativePath
                        Path = $childPath
                        Field = $field
                    })
                }
            }

            Add-JsonLocalizationReferences -Node $value -JsonPath $childPath -RelativePath $RelativePath -IsTameworkConfig $IsTameworkConfig
        }
        return
    }
}

$serverRoot = Join-Path $Root "Server"
if (-not (Test-Path -LiteralPath $serverRoot)) {
    throw "Server directory was not found at '$serverRoot'."
}

Get-ChildItem -LiteralPath $serverRoot -Recurse -File -Filter "*.json" |
    Sort-Object FullName |
    ForEach-Object {
        $json = Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json
        $relativePath = [IO.Path]::GetRelativePath($Root, $_.FullName)
        $isTameworkConfig = $relativePath -like "Server\Tamework\*"
        Add-JsonLocalizationReferences -Node $json -JsonPath "$" -RelativePath $relativePath -IsTameworkConfig $isTameworkConfig
    }

if ($rawTameworkText.Count -gt 0) {
    Write-Host "Tamework config fields with raw player-facing text:"
    $rawTameworkText |
        Select-Object -First 50 |
        ForEach-Object { Write-Host "  $($_.File) $($_.Path): $($_.Value)" }
    throw "Found $($rawTameworkText.Count) raw Tamework config text values that should use server.lang keys."
}

$requiredKeys = @($keyReferences | Select-Object -ExpandProperty Key -Unique | Sort-Object)
if ($requiredKeys.Count -eq 0) {
    throw "No language key references were found in Server JSON files."
}

$languageRoot = Join-Path $serverRoot "Languages"
foreach ($language in $requiredLanguages) {
    $languagePath = Join-Path $languageRoot "$language/server.lang"
    if (-not (Test-Path -LiteralPath $languagePath)) {
        throw "Required language file was not found: $languagePath"
    }

    $languageKeys = Read-LanguageKeys -Path $languagePath
    $missingKeys = @($requiredKeys | Where-Object { -not $languageKeys.Contains($_) })
    if ($missingKeys.Count -gt 0) {
        Write-Host "$language is missing localization keys:"
        $missingKeys |
            Select-Object -First 50 |
            ForEach-Object { Write-Host "  $_" }
        throw "$language is missing $($missingKeys.Count) referenced localization keys."
    }

    Write-Host "$language localization coverage: $($requiredKeys.Count) referenced keys, $($languageKeys.Count) available keys."
}

Write-Host "Animal Husbandry localization coverage passed for $($requiredKeys.Count) referenced keys across $($requiredLanguages.Count) languages."
