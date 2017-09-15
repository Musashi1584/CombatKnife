class X2Item_SecondaryThrowingKnives extends X2Item config(CombatKnifeMod);

var config WeaponDamageValue THROWING_KNIFE_SECONDARY_BASEDAMAGE;
var config int THROWING_KNIFE_SECONDARY_CHARGES;
var config int THROWING_KNIFE_SECONDARY_AIM;
var config int THROWING_KNIFE_SECONDARY_CRITCHANCE;
var config int THROWING_KNIFE_SECONDARY_ISOUNDRANGE;
var config int THROWING_KNIFE_SECONDARY_IENVIRONMENTDAMAGE;

var config WeaponDamageValue THROWING_KNIFE_SECONDARY_MG_BASEDAMAGE;
var config int THROWING_KNIFE_SECONDARY_MG_CHARGES;
var config int THROWING_KNIFE_SECONDARY_MG_AIM;
var config int THROWING_KNIFE_SECONDARY_MG_CRITCHANCE;
var config int THROWING_KNIFE_SECONDARY_MG_ISOUNDRANGE;
var config int THROWING_KNIFE_SECONDARY_MG_IENVIRONMENTDAMAGE;

var config WeaponDamageValue THROWING_KNIFE_SECONDARY_BM_BASEDAMAGE;
var config int THROWING_KNIFE_SECONDARY_BM_CHARGES;
var config int THROWING_KNIFE_SECONDARY_BM_AIM;
var config int THROWING_KNIFE_SECONDARY_BM_CRITCHANCE;
var config int THROWING_KNIFE_SECONDARY_BM_ISOUNDRANGE;
var config int THROWING_KNIFE_SECONDARY_BM_IENVIRONMENTDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;
	//ModWeapons.AddItem(CreateTemplate_ThrowingKnife_CV_Secondary());
	//ModWeapons.AddItem(CreateTemplate_ThrowingKnife_MG_Secondary());
	//ModWeapons.AddItem(CreateTemplate_ThrowingKnife_BM_Secondary());
	return ModWeapons;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_CV_Secondary()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ThrowingKnife_CV_Secondary');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_CV";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Kunai";
	Template.Tier = -2;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy = class'X2Item_ThrowingKnives'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.THROWING_KNIFE_SECONDARY_BASEDAMAGE;
	Template.Aim = default.THROWING_KNIFE_SECONDARY_AIM;
	Template.CritChance = default.THROWING_KNIFE_SECONDARY_CRITCHANCE;
	Template.iSoundRange = default.THROWING_KNIFE_SECONDARY_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.THROWING_KNIFE_SECONDARY_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.HideIfPurchased  = 'ThrowingKnife_MG_Secondary';

	Template.StartingItem = true;	
	Template.UpgradeItem = 'ThrowingKnife_MG_Secondary'; // Which item this can be upgraded to
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = true;
	Template.iClipSize = 99;
	Template.iPhysicsImpulse = 5;
	Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;

	Template.DamageTypeTemplateName = 'DefaultProjectile';

	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
	Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
	Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnifeSecondary');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	Template.HideIfPurchased = 'ThrowingKnife_MG_Secondary_Schematic';

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_MG_Secondary()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ThrowingKnife_MG_Secondary');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_MG";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Kunai_MG";
	
	Template.Tier = -1;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy =      class'X2Item_ThrowingKnives'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage =         default.THROWING_KNIFE_SECONDARY_MG_BASEDAMAGE;
	Template.Aim =	              default.THROWING_KNIFE_SECONDARY_MG_AIM;
	Template.CritChance =         default.THROWING_KNIFE_SECONDARY_MG_CRITCHANCE;
	Template.iSoundRange =        default.THROWING_KNIFE_SECONDARY_MG_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.THROWING_KNIFE_SECONDARY_MG_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'ThrowingKnife_MG_Secondary_Schematic'; //Important for built items.
	Template.HideIfPurchased  = 'ThrowingKnife_BM_Secondary';

	Template.StartingItem = false;	
	Template.UpgradeItem = 'ThrowingKnife_BM_Secondary'; // Which item this can be upgraded to
	Template.BaseItem = 'ThrowingKnife_CV_Secondary'; // Which item this will be upgraded from
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = true;
	Template.iClipSize = 99;
	Template.iPhysicsImpulse = 5;
	Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;
	Template.DamageTypeTemplateName = 'DefaultProjectile';

	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
    Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
    Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnifeSecondary');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	Template.HideIfPurchased = 'ThrowingKnife_BM_Secondary_Schematic';

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_BM_Secondary()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ThrowingKnife_BM_Secondary');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'throwingknife';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_BM";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_BeltHolster;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "CombatKnifeMod.Archetypes.WP_Kunai_BM";
	
	Template.Tier = 0;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.bInfiniteItem = true;

	Template.iRange = -1;
	Template.RangeAccuracy =      class'X2Item_ThrowingKnives'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage =         default.THROWING_KNIFE_SECONDARY_BM_BASEDAMAGE;
	Template.Aim =	              default.THROWING_KNIFE_SECONDARY_BM_AIM;
	Template.CritChance =         default.THROWING_KNIFE_SECONDARY_BM_CRITCHANCE;
	Template.iSoundRange =        default.THROWING_KNIFE_SECONDARY_BM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.THROWING_KNIFE_SECONDARY_BM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'ThrowingKnife_BM_Secondary_Schematic'; //Important for built items.
	
	Template.StartingItem = false;
	Template.BaseItem = 'ThrowingKnife_MG_Secondary'; // Which item this will be upgraded from
	Template.CanBeBuilt = false;
	
	Template.InfiniteAmmo = true;
	Template.iClipSize = 99;
	Template.iPhysicsImpulse = 5;
	Template.bHideWithNoAmmo = false;
	Template.bMergeAmmo = true;
	Template.DamageTypeTemplateName = 'DefaultProjectile';

	Template.WeaponPrecomputedPathData.InitialPathTime = 1.50;
    Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
    Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;
	
	Template.Abilities.AddItem('MusashiThrowKnifeSecondary');
	Template.Abilities.AddItem('ThrowingKnifeReturnFire');

	Template.SetAnimationNameForAbility('Hailstorm', 'FF_HailStormA');

	return Template;
}

static function bool IsLW2Installed()
{
	local X2DownloadableContentInfo Mod;
	foreach `ONLINEEVENTMGR.m_cachedDLCInfos (Mod)
	{
		if (Mod.Class.Name == 'X2DownloadableContentInfo_LW_Overhaul')
		{
			`Log("LW2 Mod installed:" @ Mod.Class);
			return true;
		}
	}

	return false;
}

defaultproperties
{
	bShouldCreateDifficultyVariants = true
}
