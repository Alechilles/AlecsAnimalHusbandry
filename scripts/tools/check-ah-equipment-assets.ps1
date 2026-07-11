param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..\..").Path
)

$ErrorActionPreference = "Stop"

function Require-Condition {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) {
        throw $Message
    }
}

$interactionPatchPath = Join-Path $Root "Server/Tamework/Patches/AH_Equipment_Interactions.json"
$interactionPatch = Get-Content -Raw -LiteralPath $interactionPatchPath | ConvertFrom-Json
Require-Condition ($interactionPatch.Targets.Count -eq 4) "Equipment interaction patch must target all four interaction families."
Require-Condition ($interactionPatch.Operations.Count -eq 2) "Equipment interaction patch must contain saddle and blanket operations."
foreach ($target in $interactionPatch.Targets) {
    $targetPath = Join-Path $Root $target
    Require-Condition (Test-Path -LiteralPath $targetPath) "Equipment interaction target does not exist: $target"
    $targetConfig = Get-Content -Raw -LiteralPath $targetPath | ConvertFrom-Json
    Require-Condition ($targetConfig.Interactions.Count -gt 0) "Equipment interaction target has no interaction array entries: $target"
}
foreach ($operation in $interactionPatch.Operations) {
    Require-Condition ($operation.Op -eq "Insert") "Equipment interactions must use idempotent anchored Insert operations."
    Require-Condition ($operation.Path -eq "/Interactions") "Equipment interactions must target the Interactions array."
    Require-Condition ($operation.Position -eq "Start") "Equipment interactions must run before all catch-all interactions."
    Require-Condition ($null -ne $operation.Existing.PromptHint) "Equipment interaction Insert operations require an Existing matcher."
}

$saddleInteraction = $interactionPatch.Operations[0].Value
$blanketInteraction = $interactionPatch.Operations[1].Value
Require-Condition ($saddleInteraction.Requires.All.IsTamed -eq $true) "Saddle interaction must require a tamed NPC."
Require-Condition ($saddleInteraction.Requires.All.PlayerIsOwner -eq $true) "Saddle interaction must require the owner."
Require-Condition ($blanketInteraction.Requires.All.IsTamed -eq $true) "Blanket interaction must require a tamed NPC."
Require-Condition ($blanketInteraction.Requires.All.PlayerIsOwner -eq $true) "Blanket interaction must require the owner."

$blanketItems = @($blanketInteraction.Requires.All.ItemsInHand[0].Items)
$blanketMappings = @($blanketInteraction.Effects.Custom[0].Values)
Require-Condition ($blanketItems.Count -eq 20) "Blanket interaction must accept exactly 20 full wool colors."
Require-Condition ($blanketMappings.Count -eq 20) "Blanket effect must map exactly 20 wool colors."
Require-Condition (-not ($blanketItems | Where-Object { $_ -match '_(Half|Stairs)$' })) "Blanket interaction must not accept shaped cloth variants."

$mappedItems = @($blanketMappings | ForEach-Object { ($_ -split '=', 2)[0] } | Sort-Object)
$mappedValues = @($blanketMappings | ForEach-Object { ($_ -split '=', 2)[1] } | Sort-Object -Unique)
Require-Condition (@(Compare-Object ($blanketItems | Sort-Object) $mappedItems).Count -eq 0) "Blanket requirement items and effect mapping keys must match."

$modelPatchNames = @("AH_Saddle_Horse.json", "AH_Saddle_Deer.json", "AH_Saddle_Moose.json")
foreach ($modelPatchName in $modelPatchNames) {
    $modelPatchPath = Join-Path $Root "Server/Tamework/Patches/$modelPatchName"
    $modelPatch = Get-Content -Raw -LiteralPath $modelPatchPath | ConvertFrom-Json
    $sets = $modelPatch.Operations[0].Value.RandomAttachmentSets
    Require-Condition ($sets.Saddle.None.Weight -gt 0) "$modelPatchName must keep Saddle.None as a random default."
    Require-Condition ($sets.Saddle.Yes.Weight -eq 0) "$modelPatchName must not randomly apply saddles."
    Require-Condition ($sets.SaddleBlanket.None.Weight -gt 0) "$modelPatchName must keep SaddleBlanket.None as a random default."

    $availableBlankets = @($sets.SaddleBlanket.PSObject.Properties.Name)
    foreach ($mappedValue in $mappedValues) {
        Require-Condition ($availableBlankets -contains $mappedValue) "$modelPatchName is missing blanket value '$mappedValue'."
        Require-Condition ($sets.SaddleBlanket.$mappedValue.Weight -eq 0) "$modelPatchName blanket '$mappedValue' must have zero random weight."
        $blanket = $sets.SaddleBlanket.$mappedValue
        Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($blanket.Model)"))) "$modelPatchName blanket '$mappedValue' model does not exist."
        Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($blanket.Texture)"))) "$modelPatchName blanket '$mappedValue' texture does not exist."
    }

    $saddle = $sets.Saddle.Yes
    Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddle.Model)"))) "$modelPatchName saddle model does not exist."
    Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddle.Texture)"))) "$modelPatchName saddle texture does not exist."
}

$saddleItemPath = Join-Path $Root "Server/Item/Items/Tools/AH_Saddle.json"
$saddleItem = Get-Content -Raw -LiteralPath $saddleItemPath | ConvertFrom-Json
Require-Condition ($saddleItem.Recipe.Output[0].ItemId -eq "AH_Saddle") "AH_Saddle recipe must output AH_Saddle."
Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddleItem.Model)"))) "AH_Saddle model reference does not exist."
Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddleItem.Texture)"))) "AH_Saddle texture reference does not exist."

Write-Host "Animal Husbandry equipment asset checks passed: 20 blanket colors, 3 model patches, and AH_Saddle."
