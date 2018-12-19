class X2Item_CombatKnives extends X2Item config(CombatKnifeMod);

var config bool bHidePreviousTiers;

var config name LW2_KNIFE_CATEGORY;
var config bool SHEATH_VISIBLE;

var config WeaponDamageValue KNIFE_BASEDAMAGE;
var config WeaponDamageValue KNIFE_BASEDAMAGE_LW2;
var config int KNIFE_AIM;
var config int KNIFE_CRITCHANCE;
var config int KNIFE_ISOUNDRANGE;
var config int KNIFE_IENVIRONMENTDAMAGE;
var config bool KNIFE_PANIC;
var config bool KNIFE_BURN;
var config bool KNIFE_DISORIENT;
var config int KNIFE_STUNCHANCE;

var config WeaponDamageValue KNIFE_MG_BASEDAMAGE;
var config WeaponDamageValue KNIFE_MG_BASEDAMAGE_LW2;
var config int KNIFE_MG_AIM;
var config int KNIFE_MG_CRITCHANCE;
var config int KNIFE_MG_ISOUNDRANGE;
var config int KNIFE_MG_IENVIRONMENTDAMAGE;
var config bool KNIFE_MG_PANIC;
var config bool KNIFE_MG_BURN;
var config bool KNIFE_MG_DISORIENT;
var config int KNIFE_MG_STUNCHANCE;

var config WeaponDamageValue KNIFE_BM_BASEDAMAGE;
var config WeaponDamageValue KNIFE_BM_BASEDAMAGE_LW2;
var config int KNIFE_BM_AIM;
var config int KNIFE_BM_CRITCHANCE;
var config int KNIFE_BM_ISOUNDRANGE;
var config int KNIFE_BM_IENVIRONMENTDAMAGE;
var config bool KNIFE_BM_PANIC;
var config bool KNIFE_BM_BURN;
var config bool KNIFE_BM_DISORIENT;
var config int KNIFE_BM_STUNCHANCE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;
	ModWeapons.AddItem(CreateTemplate_SpecOpsKnife_CV());
	ModWeapons.AddItem(CreateTemplate_SpecOpsKnife_MG());
	ModWeapons.AddItem(CreateTemplate_SpecOpsKnife_BM());
	return ModWeapons;
}

static function X2DataTemplate CreateTemplate_SpecOpsKnife_CV()
{
	local X2WeaponTemplate Template;
	
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SpecOpsKnife_CV');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_knife";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "XComWeapon'CombatKnifeMod.Archetypes.wp_so_knife'";
	
	Template.Tier = 0;
	
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	if (IsLW2Installed())
	{
		Template.BaseDamage = default.KNIFE_BASEDAMAGE_LW2;
	}
	else
	{
		Template.BaseDamage = default.KNIFE_BASEDAMAGE;
	}
	Template.Aim = default.KNIFE_AIM;
	Template.CritChance = default.KNIFE_CRITCHANCE;
	Template.iSoundRange = default.KNIFE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.KNIFE_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	//Template.CreatorTemplateName = 'SpecOpsKnife_CV_Schematic'; //Important for built items.
	
	Template.StartingItem = true;	
	Template.UpgradeItem = 'SpecOpsKnife_MG';
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.DamageTypeTemplateName = 'Melee';

	if (default.KNIFE_STUNCHANCE > 0)
		Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.KNIFE_STUNCHANCE));
	if (default.KNIFE_PANIC)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreatePanickedStatusEffect());}
	if (default.KNIFE_BURN)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));}
	if (default.KNIFE_DISORIENT)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());}
	
	Template.Abilities.AddItem('MusashiCombatKnifeBonus');
	Template.Abilities.AddItem('SilentTakedown');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'Musashi_CK_AbilitySet'.default.COMBAT_KNIFE_MOBILITY_BONUS);

	if (default.bHidePreviousTiers)
		Template.HideIfPurchased = 'SpecOpsKnife_MG_Schematic';

	if (IsLW2Installed())
	{
		Template.WeaponCat = default.LW2_KNIFE_CATEGORY;
	}

	return Template;
}

static function X2DataTemplate CreateTemplate_SpecOpsKnife_MG()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SpecOpsKnife_MG');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_Knife_MG";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "XComWeapon'CombatKnifeMod.Archetypes.wp_so_knife_mg'";
	
	Template.Tier = 2;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	if (IsLW2Installed())
	{
		Template.BaseDamage = default.Knife_MG_BASEDAMAGE_LW2;
	}
	else
	{
		Template.BaseDamage = default.Knife_MG_BASEDAMAGE;
	}
	Template.BaseDamage = default.Knife_MG_BASEDAMAGE;
	Template.Aim = default.Knife_MG_AIM;
	Template.CritChance = default.Knife_MG_CRITCHANCE;
	Template.iSoundRange = default.Knife_MG_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.Knife_MG_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'SpecOpsKnife_MG_Schematic'; //Important for built items.
	
	Template.StartingItem = false;	
	Template.UpgradeItem = 'SpecOpsKnife_BM'; // Which item this can be upgraded to
	Template.BaseItem = 'SpecOpsKnife_CV'; // Which item this will be upgraded from
	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.DamageTypeTemplateName = 'Melee';

	if (default.KNIFE_MG_STUNCHANCE > 0)
		Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.KNIFE_MG_STUNCHANCE));
	if (default.KNIFE_MG_PANIC)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreatePanickedStatusEffect());}
	if (default.KNIFE_MG_BURN)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));}
	if (default.KNIFE_MG_DISORIENT)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());}
	
	Template.Abilities.AddItem('MusashiCombatKnifeBonus');
	Template.Abilities.AddItem('SilentTakedown');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'Musashi_CK_AbilitySet'.default.COMBAT_KNIFE_MOBILITY_BONUS);

	if (default.bHidePreviousTiers)
		Template.HideIfPurchased = 'SpecOpsKnife_BM_Schematic';

	if (IsLW2Installed())
	{
		Template.WeaponCat = default.LW2_KNIFE_CATEGORY;
	}

	return Template;
}

static function X2DataTemplate CreateTemplate_SpecOpsKnife_BM()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SpecOpsKnife_BM');
	
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_Knife_BM";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "XComWeapon'CombatKnifeMod.Archetypes.wp_so_knife_bm'";
	
	Template.Tier = 4;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	if (IsLW2Installed())
	{
		Template.BaseDamage = default.KNIFE_BM_BASEDAMAGE_LW2;
	}
	else
	{
		Template.BaseDamage = default.KNIFE_BM_BASEDAMAGE;
	}
	Template.Aim = default.KNIFE_BM_AIM;
	Template.CritChance = default.KNIFE_BM_CRITCHANCE;
	Template.iSoundRange = default.KNIFE_BM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.KNIFE_BM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'SpecOpsKnife_BM_Schematic'; //Important for built items.
	
	Template.BaseItem = 'SpecOpsKnife_MG'; // Which item this will be upgraded from
	Template.StartingItem = false;	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.DamageTypeTemplateName = 'Melee';

	if (default.KNIFE_BM_STUNCHANCE > 0)
		Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.KNIFE_BM_STUNCHANCE));
	if (default.KNIFE_BM_PANIC)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreatePanickedStatusEffect());}
	if (default.KNIFE_BM_BURN)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));}
	if (default.KNIFE_BM_DISORIENT)
		{Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());}
	
	Template.Abilities.AddItem('MusashiCombatKnifeBonus');
	Template.Abilities.AddItem('SilentTakedown');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'Musashi_CK_AbilitySet'.default.COMBAT_KNIFE_MOBILITY_BONUS);

	if (IsLW2Installed())
	{
		Template.WeaponCat = default.LW2_KNIFE_CATEGORY;
	}

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
