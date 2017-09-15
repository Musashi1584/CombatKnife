class X2Item_Shuriken extends X2Item config(CombatKnifeMod);

var config WeaponDamageValue SHURIKEN_CV_BASEDAMAGE;
var config int SHURIKEN_CV_CHARGES;
var config int SHURIKEN_CV_AIM;
var config int SHURIKEN_CV_CRITCHANCE;
var config int SHURIKEN_CV_ISOUNDRANGE;
var config int SHURIKEN_CV_IENVIRONMENTDAMAGE;

var config WeaponDamageValue SHURIKEN_MG_BASEDAMAGE;
var config int SHURIKEN_MG_CHARGES;
var config int SHURIKEN_MG_AIM;
var config int SHURIKEN_MG_CRITCHANCE;
var config int SHURIKEN_MG_ISOUNDRANGE;
var config int SHURIKEN_MG_IENVIRONMENTDAMAGE;

var config WeaponDamageValue SHURIKEN_BM_BASEDAMAGE;
var config int SHURIKEN_BM_CHARGES;
var config int SHURIKEN_BM_AIM;
var config int SHURIKEN_BM_CRITCHANCE;
var config int SHURIKEN_BM_ISOUNDRANGE;
var config int SHURIKEN_BM_IENVIRONMENTDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;
	//ModWeapons.AddItem(CreateTemplate_Shuriken_CV());
	//ModWeapons.AddItem(CreateTemplate_Shuriken_MG());
	//ModWeapons.AddItem(CreateTemplate_Shuriken_BM());
	return ModWeapons;
}

static function X2DataTemplate CreateTemplate_Shuriken_CV()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Shuriken_CV');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_throwingknife";
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
	Template.RangeAccuracy = class'X2Item_ThrowingKnives'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.SHURIKEN_CV_BASEDAMAGE;
	Template.Aim = default.SHURIKEN_CV_AIM;
	Template.CritChance = default.SHURIKEN_CV_CRITCHANCE;
	Template.iSoundRange = default.SHURIKEN_CV_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.SHURIKEN_CV_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'Shuriken_CV_Schematic'; //Important for built items.
	Template.HideIfPurchased  = 'Shuriken_MG';

	Template.StartingItem = false;	
	Template.UpgradeItem = 'Shuriken_MG'; // Which item this can be upgraded to
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = false;
	Template.iClipSize = default.SHURIKEN_CV_CHARGES;
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

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	Template.HideIfPurchased = 'Shuriken_MG_Schematic';

	return Template;
}

static function X2DataTemplate CreateTemplate_Shuriken_MG()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Shuriken_MG');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_throwingknife";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Shuriken2";
	
	Template.Tier = -1;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy =      class'X2Item_ThrowingKnives'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage =         default.SHURIKEN_MG_BASEDAMAGE;
	Template.Aim =	              default.SHURIKEN_MG_AIM;
	Template.CritChance =         default.SHURIKEN_MG_CRITCHANCE;
	Template.iSoundRange =        default.SHURIKEN_MG_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.SHURIKEN_MG_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'Shuriken_MG_Schematic'; //Important for built items.
	Template.HideIfPurchased  = 'Shuriken_BM';

	Template.StartingItem = false;	
	Template.UpgradeItem = 'Shuriken_BM'; // Which item this can be upgraded to
	Template.BaseItem = 'Shuriken_CV'; // Which item this will be upgraded from
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = false;
    Template.iClipSize = default.SHURIKEN_MG_CHARGES;
    Template.iPhysicsImpulse = 5;
    Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;
	Template.DamageTypeTemplateName = 'DefaultProjectile';

	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
    Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
    Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnife');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	Template.HideIfPurchased = 'Shuriken_BM_Schematic';

	return Template;
}

static function X2DataTemplate CreateTemplate_Shuriken_BM()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Shuriken_BM');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_throwingknife";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Shuriken3";
	
	Template.Tier = 0;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy =      class'X2Item_ThrowingKnives'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage =         default.SHURIKEN_BM_BASEDAMAGE;
	Template.Aim =	              default.SHURIKEN_BM_AIM;
	Template.CritChance =         default.SHURIKEN_BM_CRITCHANCE;
	Template.iSoundRange =        default.SHURIKEN_BM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.SHURIKEN_BM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'Shuriken_BM_Schematic'; //Important for built items.
	
	Template.StartingItem = false;
	Template.BaseItem = 'Shuriken_MG'; // Which item this will be upgraded from
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = false;
    Template.iClipSize = default.SHURIKEN_BM_CHARGES;
    Template.iPhysicsImpulse = 5;
    Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;
	Template.DamageTypeTemplateName = 'DefaultProjectile';

	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
    Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
    Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnife');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	return Template;
}

defaultproperties
{
	bShouldCreateDifficultyVariants = true
}
