param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..\..").Path
)

$ErrorActionPreference = "Stop"

$expectedKey = "server.npcRoles.Fox_Arctic.name"
$rolePaths = @(
    "Server/NPC/Roles/Creature/Mammal/Fox_Arctic.json",
    "Server/NPC/Roles/Creature/Mammal/Tamed/Tamed_Fox_Arctic.json"
)
$requiredLanguages = @("en-US", "de-DE", "fr-FR", "fr-CA", "pt-BR")

foreach ($relativePath in $rolePaths) {
    $path = Join-Path $Root $relativePath
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required Arctic Fox role was not found: $relativePath"
    }

    $role = Get-Content -Raw -LiteralPath $path | ConvertFrom-Json
    $actualKey = $role.Parameters.NameTranslationKey.Value
    if ($actualKey -ne $expectedKey) {
        throw "$relativePath uses '$actualKey' but should use '$expectedKey'."
    }
}

foreach ($language in $requiredLanguages) {
    $languagePath = Join-Path $Root "Server/Languages/$language/server.lang"
    if (-not (Test-Path -LiteralPath $languagePath)) {
        throw "Required language file was not found: $languagePath"
    }

    $keyPattern = "server.npcRoles.Fox_Arctic.name="
    $matchingLine = Get-Content -LiteralPath $languagePath |
        Where-Object { $_.StartsWith($keyPattern, [System.StringComparison]::Ordinal) } |
        Select-Object -First 1

    if ([string]::IsNullOrWhiteSpace($matchingLine)) {
        throw "$language is missing $keyPattern"
    }

    $value = $matchingLine.Substring($keyPattern.Length).Trim()
    if ([string]::IsNullOrWhiteSpace($value)) {
        throw "$language defines $keyPattern with an empty value."
    }
}

Write-Host "Arctic Fox localization is wired for wild and tamed roles across $($requiredLanguages.Count) languages."
