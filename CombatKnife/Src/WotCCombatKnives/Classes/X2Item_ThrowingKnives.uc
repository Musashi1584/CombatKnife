class X2Item_ThrowingKnives extends X2Item config(CombatKnifeMod);

var config bool bHidePreviousTiers;

var config array<int> SHORT_CONVENTIONAL_RANGE;

var config WeaponDamageValue THROWING_KNIFE_BASEDAMAGE;
var config int THROWING_KNIFE_CHARGES;
var config int THROWING_KNIFE_AIM;
var config int THROWING_KNIFE_CRITCHANCE;
var config int THROWING_KNIFE_ISOUNDRANGE;
var config int THROWING_KNIFE_IENVIRONMENTDAMAGE;

var config WeaponDamageValue THROWING_KNIFE_MG_BASEDAMAGE;
var config int THROWING_KNIFE_MG_CHARGES;
var config int THROWING_KNIFE_MG_AIM;
var config int THROWING_KNIFE_MG_CRITCHANCE;
var config int THROWING_KNIFE_MG_ISOUNDRANGE;
var config int THROWING_KNIFE_MG_IENVIRONMENTDAMAGE;

var config WeaponDamageValue THROWING_KNIFE_BM_BASEDAMAGE;
var config int THROWING_KNIFE_BM_CHARGES;
var config int THROWING_KNIFE_BM_AIM;
var config int THROWING_KNIFE_BM_CRITCHANCE;
var config int THROWING_KNIFE_BM_ISOUNDRANGE;
var config int THROWING_KNIFE_BM_IENVIRONMENTDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;
	ModWeapons.AddItem(CreateTemplate_ThrowingKnife_CV());
	ModWeapons.AddItem(CreateTemplate_ThrowingKnife_MG());
	ModWeapons.AddItem(CreateTemplate_ThrowingKnife_BM());
	return ModWeapons;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_CV()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ThrowingKnife_CV');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_CV";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Kunai";
	
	Template.Tier = -2;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy = default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.THROWING_KNIFE_BASEDAMAGE;
	Template.Aim = default.THROWING_KNIFE_AIM;
	Template.CritChance = default.THROWING_KNIFE_CRITCHANCE;
	Template.iSoundRange = default.THROWING_KNIFE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.THROWING_KNIFE_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'ThrowingKnife_CV_Schematic'; //Important for built items.
	Template.HideIfPurchased  = 'ThrowingKnife_MG';

	Template.StartingItem = false;	
	Template.UpgradeItem = 'ThrowingKnife_MG'; // Which item this can be upgraded to
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = false;
	Template.iClipSize = default.THROWING_KNIFE_CHARGES;
	Template.iPhysicsImpulse = 5;
	Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;
	//Template.BaseItem = 'SO_Knife';
	Template.DamageTypeTemplateName = 'DefaultProjectile';
	
	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
	Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
	Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnife');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');
	Template.Abilities.AddItem('SilentKillPassive');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	if (default.bHidePreviousTiers)
		Template.HideIfPurchased = 'ThrowingKnife_MG_Schematic';

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_MG()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ThrowingKnife_MG');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_MG";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Kunai_MG";
	
	Template.Tier = -1;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy =      default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage =         default.THROWING_KNIFE_MG_BASEDAMAGE;
	Template.Aim =	              default.THROWING_KNIFE_MG_AIM;
	Template.CritChance =         default.THROWING_KNIFE_MG_CRITCHANCE;
	Template.iSoundRange =        default.THROWING_KNIFE_MG_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.THROWING_KNIFE_MG_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'ThrowingKnife_MG_Schematic'; //Important for built items.
	Template.HideIfPurchased  = 'ThrowingKnife_BM';

	Template.StartingItem = false;	
	Template.UpgradeItem = 'ThrowingKnife_BM'; // Which item this can be upgraded to
	Template.BaseItem = 'ThrowingKnife_CV'; // Which item this will be upgraded from
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = false;
    Template.iClipSize = default.THROWING_KNIFE_MG_CHARGES;
    Template.iPhysicsImpulse = 5;
    Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;
	Template.DamageTypeTemplateName = 'DefaultProjectile';

	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
    Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
    Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnife');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');
	Template.Abilities.AddItem('SilentKillPassive');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	if (default.bHidePreviousTiers)
		Template.HideIfPurchased = 'ThrowingKnife_BM_Schematic';

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_BM()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ThrowingKnife_BM');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_BM";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Kunai_BM";
	
	Template.Tier = 0;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy =      default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage =         default.THROWING_KNIFE_BM_BASEDAMAGE;
	Template.Aim =	              default.THROWING_KNIFE_BM_AIM;
	Template.CritChance =         default.THROWING_KNIFE_BM_CRITCHANCE;
	Template.iSoundRange =        default.THROWING_KNIFE_BM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.THROWING_KNIFE_BM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'ThrowingKnife_BM_Schematic'; //Important for built items.
	
	Template.StartingItem = false;
	Template.BaseItem = 'ThrowingKnife_MG'; // Which item this will be upgraded from
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = false;
    Template.iClipSize = default.THROWING_KNIFE_BM_CHARGES;
    Template.iPhysicsImpulse = 5;
    Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;
	Template.DamageTypeTemplateName = 'DefaultProjectile';

	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
    Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
    Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnife');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');
	Template.Abilities.AddItem('SilentKillPassive');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	return Template;
}

defaultproperties
{
	bShouldCreateDifficultyVariants = true
}
