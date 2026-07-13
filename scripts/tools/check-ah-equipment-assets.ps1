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
Require-Condition ($saddleInteraction.Requires.All.Custom[0].Id -eq "tamework:attachment_exchange_available") "Saddle equip must use the attachment exchange gate."
Require-Condition ($saddleInteraction.Effects.Custom[0].Id -eq "tamework:exchange_attachment") "Saddle equip must use the atomic attachment exchange effect."
Require-Condition ($blanketInteraction.Requires.All.Custom[0].Id -eq "tamework:attachment_exchange_available") "Blanket equip must use the attachment exchange gate."
Require-Condition ($blanketInteraction.Effects.Custom[0].Id -eq "tamework:exchange_attachment") "Blanket equip must use the atomic attachment exchange effect."

$blanketItems = @($blanketInteraction.Requires.All.ItemsInHand[0].Items)
$blanketRequirementMappings = @($blanketInteraction.Requires.All.Custom[0].Values)
$blanketMappings = @($blanketInteraction.Effects.Custom[0].Values)
Require-Condition ($blanketItems.Count -eq 20) "Blanket interaction must accept exactly 20 full wool colors."
Require-Condition ($blanketRequirementMappings.Count -eq 20) "Blanket exchange gate must map exactly 20 wool colors."
Require-Condition ($blanketMappings.Count -eq 20) "Blanket effect must map exactly 20 wool colors."
Require-Condition (-not ($blanketItems | Where-Object { $_ -match '_(Half|Stairs)$' })) "Blanket interaction must not accept shaped cloth variants."
Require-Condition (@(Compare-Object ($blanketRequirementMappings | Sort-Object) ($blanketMappings | Sort-Object)).Count -eq 0) "Blanket requirement and effect mappings must match."

$mappedItems = @($blanketMappings | ForEach-Object { ($_ -split '=', 2)[0] } | Sort-Object)
$mappedValues = @($blanketMappings | ForEach-Object { ($_ -split '=', 2)[1] } | Sort-Object -Unique)
Require-Condition (@(Compare-Object ($blanketItems | Sort-Object) $mappedItems).Count -eq 0) "Blanket requirement items and effect mapping keys must match."
Require-Condition (-not ($mappedValues -contains "Canada")) "The appearance-only Canada blanket must not be mapped to a fabricated refund item."

$removalPatchPath = Join-Path $Root "Server/Tamework/Patches/AH_Equipment_Removal_Interactions.json"
$removalPatch = Get-Content -Raw -LiteralPath $removalPatchPath | ConvertFrom-Json
$expectedRemovalTargets = @(
    "Server/Tamework/Interactions/AHIntLivestock.json",
    "Server/Tamework/Interactions/AHIntNeutral.json",
    "Server/Tamework/Interactions/AHIntBeast.json"
)
Require-Condition ($removalPatch.Targets.Count -eq 3) "Equipment removal patch must target the three interaction families with Pet support."
Require-Condition (@(Compare-Object ($removalPatch.Targets | Sort-Object) ($expectedRemovalTargets | Sort-Object)).Count -eq 0) "Equipment removal targets must match the Pet-enabled interaction families."
Require-Condition ($removalPatch.Operations.Count -eq 2) "Equipment removal patch must contain saddle and blanket operations."
foreach ($target in $removalPatch.Targets) {
    $targetPath = Join-Path $Root $target
    $targetConfig = Get-Content -Raw -LiteralPath $targetPath | ConvertFrom-Json
    $petInteraction = $targetConfig.Interactions | Where-Object {
        $promptProperty = $_.PSObject.Properties["PromptHint"]
        $null -ne $promptProperty -and $promptProperty.Value -eq "server.interactionHints.pet"
    }
    Require-Condition ($null -ne $petInteraction) "Removal target must contain the Pet anchor: $target"
}

$saddleRemovalOperation = $removalPatch.Operations[0]
$blanketRemovalOperation = $removalPatch.Operations[1]
Require-Condition ($saddleRemovalOperation.Op -eq "Insert" -and $blanketRemovalOperation.Op -eq "Insert") "Equipment removals must use Insert operations."
Require-Condition ($saddleRemovalOperation.Position -eq "After" -and $blanketRemovalOperation.Position -eq "After") "Equipment removals must use anchored After placement."
Require-Condition ($saddleRemovalOperation.Find.PromptHint -eq "server.interactionHints.pet") "Saddle removal must be inserted after Pet."
Require-Condition ($blanketRemovalOperation.Find.PromptHint -eq "server.animalhusbandry.interactions.removeSaddle") "Blanket removal must be inserted after Saddle removal."
Require-Condition ($saddleRemovalOperation.Existing.PromptHint -eq "server.animalhusbandry.interactions.removeSaddle") "Saddle removal requires an idempotency matcher."
Require-Condition ($blanketRemovalOperation.Existing.PromptHint -eq "server.animalhusbandry.interactions.removeBlanket") "Blanket removal requires an idempotency matcher."

$saddleRemoval = $saddleRemovalOperation.Value
$blanketRemoval = $blanketRemovalOperation.Value
foreach ($removal in @($saddleRemoval, $blanketRemoval)) {
    Require-Condition ($removal.Requires.All.IsTamed -eq $true) "Equipment removal must require a tamed NPC."
    Require-Condition ($removal.Requires.All.PlayerIsOwner -eq $true) "Equipment removal must require the owner."
    Require-Condition ($removal.Requires.All.PlayerHandEmpty -eq $true) "Equipment removal must require an empty hand."
    Require-Condition ($removal.Requires.All.Custom[0].Id -eq "tamework:attachment_exchange_available") "Equipment removal must use the attachment exchange gate."
    Require-Condition ($removal.Effects.Custom[0].Id -eq "tamework:exchange_attachment") "Equipment removal must use the atomic attachment exchange effect."
    Require-Condition (@(Compare-Object ($removal.Requires.All.Custom[0].Values | Sort-Object) ($removal.Effects.Custom[0].Values | Sort-Object)).Count -eq 0) "Equipment removal requirement and effect mappings must match."
}
Require-Condition (@(Compare-Object ($saddleRemoval.Effects.Custom[0].Values | Sort-Object) ($saddleInteraction.Effects.Custom[0].Values | Sort-Object)).Count -eq 0) "Saddle equip and removal mappings must match."
Require-Condition (@(Compare-Object ($blanketRemoval.Effects.Custom[0].Values | Sort-Object) ($blanketMappings | Sort-Object)).Count -eq 0) "Blanket equip and removal mappings must match."

$languagePaths = @(Get-ChildItem -LiteralPath (Join-Path $Root "Server/Languages") -Filter "server.lang" -Recurse)
Require-Condition ($languagePaths.Count -eq 5) "Expected five localized server.lang files."
$equipmentPromptKeys = @(
    "applySaddle",
    "applyBlanket",
    "removeSaddle",
    "removeBlanket"
)
foreach ($languagePath in $languagePaths) {
    $languageText = Get-Content -Raw -LiteralPath $languagePath.FullName
    foreach ($promptKey in $equipmentPromptKeys) {
        $promptPattern = "(?m)^animalhusbandry\.interactions\.$promptKey=.*<key>.*$"
        Require-Condition ($languageText -match $promptPattern) "Equipment prompt '$promptKey' must contain <key> in $($languagePath.FullName)."
    }
}
$englishLanguage = Get-Content -Raw -LiteralPath (Join-Path $Root "Server/Languages/en-US/server.lang")
$expectedEnglishPrompts = @(
    "animalhusbandry.interactions.applySaddle=Press <key> to equip Saddle",
    "animalhusbandry.interactions.applyBlanket=Press <key> to equip Blanket",
    "animalhusbandry.interactions.removeSaddle=Press <key> to remove Saddle",
    "animalhusbandry.interactions.removeBlanket=Press <key> to remove Blanket"
)
foreach ($expectedPrompt in $expectedEnglishPrompts) {
    Require-Condition ($englishLanguage -match "(?m)^$([regex]::Escape($expectedPrompt))$") "Missing exact English equipment prompt: $expectedPrompt"
}

$expectedModelTargets = @(
    "Server/Models/Beast/Bear_Grizzly.json",
    "Server/Models/Beast/Bear_Polar.json",
    "Server/Models/Beast/Emberwulf.json",
    "Server/Models/Beast/Leopard_Snow.json",
    "Server/Models/Beast/Raptor_Cave.json",
    "Server/Models/Beast/Rex_Cave.json",
    "Server/Models/Beast/Scorpion.json",
    "Server/Models/Beast/Spider.json",
    "Server/Models/Beast/Spider_Cave.json",
    "Server/Models/Beast/Tamed_Wolf_Black.json",
    "Server/Models/Beast/Tamed_Wolf_White.json",
    "Server/Models/Beast/Tiger_Sabertooth.json",
    "Server/Models/Livestock/Bison.json",
    "Server/Models/Livestock/Camel.json",
    "Server/Models/Livestock/Cow.json",
    "Server/Models/Livestock/Horse.json",
    "Server/Models/Livestock/Ram.json",
    "Server/Models/Swimming_Beast/Crab.json",
    "Server/Models/Swimming_Beast/Crocodile.json",
    "Server/Models/Swimming_Beast/Lobster.json",
    "Server/Models/Undead/Horse_Skeleton.json",
    "Server/Models/Undead/Horse_Skeleton_Armored.json",
    "Server/Models/Wildlife/Antelope.json",
    "Server/Models/Wildlife/Deer_Doe.json",
    "Server/Models/Wildlife/Model_Deer_Stag.json",
    "Server/Models/Wildlife/Moose_Bull.json",
    "Server/Models/Wildlife/Moose_Cow.json",
    "Server/Models/Wildlife/Mosshorn.json",
    "Server/Models/Wildlife/Mosshorn_Plain.json",
    "Server/Models/Wildlife/Tetrabird.json",
    "Server/Models/Wildlife/Tortoise.json",
    "Server/Models/Wildlife/Trillodon.json"
)
$expectedBlanketPatches = @(
    "AH_Saddle_Deer.json",
    "AH_Saddle_Horse.json",
    "AH_Saddle_Horse_Skeleton.json",
    "AH_Saddle_Moose.json",
    "AH_Saddle_Mosshorn.json"
)
$expectedBlanketTextures = @{
    Black = "Blanket_Black.png"
    Blue = "Blanket_Blue.png"
    LightBlue = "Blanket_Blue_Light.png"
    Cyan = "Blanket_Cyan.png"
    LightCyan = "Blanket_Cyan_Light.png"
    Gray = "Blanket_Gray.png"
    LightGray = "Blanket_Gray_Light.png"
    Green = "Blanket_Green.png"
    LightGreen = "Blanket_Green_Light.png"
    Orange = "Blanket_Orange.png"
    LightOrange = "Blanket_Orange_Light.png"
    Pink = "Blanket_Pink.png"
    LightPink = "Blanket_Pink_Light.png"
    Purple = "Blanket_Purple.png"
    LightPurple = "Blanket_Purple_Light.png"
    Red = "Blanket_Red.png"
    LightRed = "Blanket_Red_Light.png"
    White = "Blanket_White.png"
    Yellow = "Blanket_Yellow.png"
    LightYellow = "Blanket_Yellow_Light.png"
}

$modelPatchPaths = @(Get-ChildItem -LiteralPath (Join-Path $Root "Server/Tamework/Patches") -Filter "AH_Saddle_*.json")
Require-Condition ($modelPatchPaths.Count -eq 21) "Expected 21 saddle model patches, found $($modelPatchPaths.Count)."

$actualModelTargets = @()
$actualBlanketPatches = @()
foreach ($modelPatchPath in $modelPatchPaths) {
    $modelPatchName = $modelPatchPath.Name
    $modelPatch = Get-Content -Raw -LiteralPath $modelPatchPath.FullName | ConvertFrom-Json
    $targetProperty = $modelPatch.PSObject.Properties["Target"]
    $targetsProperty = $modelPatch.PSObject.Properties["Targets"]
    if ($null -ne $targetProperty) {
        $actualModelTargets += $targetProperty.Value
    }
    if ($null -ne $targetsProperty) {
        $actualModelTargets += @($targetsProperty.Value)
    }

    $sets = $modelPatch.Operations[0].Value.RandomAttachmentSets
    Require-Condition ($null -ne $sets.Saddle) "$modelPatchName must define a Saddle attachment set."
    Require-Condition ($sets.Saddle.None.Weight -gt 0) "$modelPatchName must keep Saddle.None as a random default."
    Require-Condition ($sets.Saddle.Yes.Weight -eq 0) "$modelPatchName must not randomly apply saddles."
    foreach ($saddleValue in @("None", "Yes")) {
        $saddle = $sets.Saddle.$saddleValue
        Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddle.Model)"))) "$modelPatchName saddle '$saddleValue' model does not exist."
        Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddle.Texture)"))) "$modelPatchName saddle '$saddleValue' texture does not exist."
    }

    $blanketSetProperty = $sets.PSObject.Properties["SaddleBlanket"]
    if ($null -eq $blanketSetProperty) {
        Require-Condition (-not ($expectedBlanketPatches -contains $modelPatchName)) "$modelPatchName must define its supplied SaddleBlanket model."
        continue
    }

    $blanketSet = $blanketSetProperty.Value
    $actualBlanketPatches += $modelPatchName
    Require-Condition ($expectedBlanketPatches -contains $modelPatchName) "$modelPatchName unexpectedly defines SaddleBlanket support."
    Require-Condition ($blanketSet.None.Weight -gt 0) "$modelPatchName must keep SaddleBlanket.None as a random default."
    $availableBlankets = @($blanketSet.PSObject.Properties.Name)
    foreach ($mappedValue in $mappedValues) {
        Require-Condition ($availableBlankets -contains $mappedValue) "$modelPatchName is missing blanket value '$mappedValue'."
        $blanket = $blanketSet.$mappedValue
        Require-Condition ($blanket.Weight -eq 0) "$modelPatchName blanket '$mappedValue' must have zero random weight."
        $expectedTexture = "NPC/Wildlife/Moose/Models/Attachments/$($expectedBlanketTextures[$mappedValue])"
        Require-Condition ($blanket.Texture -eq $expectedTexture) "$modelPatchName blanket '$mappedValue' uses '$($blanket.Texture)' instead of '$expectedTexture'."
    }
    foreach ($blanketProperty in $blanketSet.PSObject.Properties) {
        $blanket = $blanketProperty.Value
        if ($blanketProperty.Name -ne "None") {
            Require-Condition ($blanket.Weight -eq 0) "$modelPatchName blanket '$($blanketProperty.Name)' must have zero random weight."
        }
        Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($blanket.Model)"))) "$modelPatchName blanket '$($blanketProperty.Name)' model does not exist."
        Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($blanket.Texture)"))) "$modelPatchName blanket '$($blanketProperty.Name)' texture does not exist."
    }
}

$duplicateTargets = @($actualModelTargets | Group-Object | Where-Object { $_.Count -gt 1 })
$duplicateTargetNames = @($duplicateTargets | ForEach-Object { $_.Name })
Require-Condition ($duplicateTargets.Count -eq 0) "Saddle model targets must not be patched more than once: $($duplicateTargetNames -join ', ')"
Require-Condition (@(Compare-Object ($expectedModelTargets | Sort-Object) ($actualModelTargets | Sort-Object)).Count -eq 0) "Saddle model patches must cover exactly the 32 mountable model targets."
Require-Condition (@(Compare-Object ($expectedBlanketPatches | Sort-Object) ($actualBlanketPatches | Sort-Object)).Count -eq 0) "Blanket model patches do not match the five supplied blanket model families."

$saddleItemPath = Join-Path $Root "Server/Item/Items/Tools/AH_Saddle.json"
$saddleItem = Get-Content -Raw -LiteralPath $saddleItemPath | ConvertFrom-Json
Require-Condition ($saddleItem.Recipe.Output[0].ItemId -eq "AH_Saddle") "AH_Saddle recipe must output AH_Saddle."
Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddleItem.Model)"))) "AH_Saddle model reference does not exist."
Require-Condition ((Test-Path -LiteralPath (Join-Path $Root "Common/$($saddleItem.Texture)"))) "AH_Saddle texture reference does not exist."

Write-Host "Animal Husbandry equipment asset checks passed: atomic equip/replacement, Pet-first Saddle/Blanket removal, exact refunds, 20 blanket colors, 21 saddle patches, 32 model targets, 5 blanket patches, and AH_Saddle."
