class Musashi_CK_Schematic extends X2Item config(CombatKnifeMod);

var config int THROWING_KNIFE_T1_RESCOST;
var config int THROWING_KNIFE_T2_RESCOST;
var config int THROWING_KNIFE_T2_MAT1COST;
var config int THROWING_KNIFE_T3_RESCOST;
var config int THROWING_KNIFE_T3_MAT1COST;
var config int THROWING_KNIFE_T3_MAT2COST;

var config int KNIFE_T1_RESCOST;
var config int KNIFE_T1_MAT1COST;
var config int KNIFE_T1_MAT2COST;

var config int KNIFE_T2_RESCOST;
var config int KNIFE_T2_MAT1COST;
var config int KNIFE_T2_MAT2COST;

var config int KNIFE_T3_RESCOST;
var config int KNIFE_T3_MAT1COST;
var config int KNIFE_T3_MAT2COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Schematics;
	
	// Weapon Schematics
	//Schematics.AddItem(CreateTemplate_ThrowingKnife_MG_Secondary_Schematic());
	//Schematics.AddItem(CreateTemplate_ThrowingKnife_BM_Secondary_Schematic());

	Schematics.AddItem(CreateTemplate_ThrowingKnife_CV_Schematic());
	Schematics.AddItem(CreateTemplate_ThrowingKnife_MG_Schematic());
	Schematics.AddItem(CreateTemplate_ThrowingKnife_BM_Schematic());
	
	//Schematics.AddItem(CreateTemplate_Shuriken_CV_Schematic());
	//Schematics.AddItem(CreateTemplate_Shuriken_MG_Schematic());
	//Schematics.AddItem(CreateTemplate_Shuriken_BM_Schematic());

	Schematics.AddItem(CreateTemplate_SpecOpsKnife_MG_Schematic());
	Schematics.AddItem(CreateTemplate_SpecOpsKnife_BM_Schematic());
	return Schematics;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_MG_Secondary_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'ThrowingKnife_MG_Secondary_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_CV";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('ThrowingKnife_CV_Secondary');
	Template.ReferenceItemTemplate = 'ThrowingKnife_MG_Secondary';
	Template.HideIfPurchased = 'ThrowingKnife_BM_Secondary';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	//Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T2_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.THROWING_KNIFE_T2_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_BM_Secondary_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'ThrowingKnife_BM_Secondary_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_MG";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 3;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('ThrowingKnife_CV_Secondary');
	Template.ItemsToUpgrade.AddItem('ThrowingKnife_MG_Secondary');
	Template.ReferenceItemTemplate = 'ThrowingKnife_BM_Secondary';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	//Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T3_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.THROWING_KNIFE_T3_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = default.THROWING_KNIFE_T3_MAT2COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}


static function X2DataTemplate CreateTemplate_ThrowingKnife_CV_Schematic()
{	
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'ThrowingKnife_CV_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_CV"; 
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;
	Template.HideIfPurchased = 'ThrowingKnife_MG';
	Template.ReferenceItemTemplate = 'ThrowingKnife_CV';
	
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventOfficer');

	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T1_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_MG_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'ThrowingKnife_MG_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_MG";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('ThrowingKnife_CV');
	Template.ReferenceItemTemplate = 'ThrowingKnife_MG';
	Template.HideIfPurchased = 'ThrowingKnife_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	//Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T2_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.THROWING_KNIFE_T2_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_BM_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'ThrowingKnife_BM_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.UI.UI_Kunai_BM";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 3;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('ThrowingKnife_CV');
	Template.ItemsToUpgrade.AddItem('ThrowingKnife_MG');
	Template.ReferenceItemTemplate = 'ThrowingKnife_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	//Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T3_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.THROWING_KNIFE_T3_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = default.THROWING_KNIFE_T3_MAT2COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}


static function X2DataTemplate CreateTemplate_Shuriken_CV_Schematic()
{	
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'Shuriken_CV_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_throwingknife"; 
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;
	Template.HideIfPurchased = 'Shuriken_MG';
	Template.ReferenceItemTemplate = 'Shuriken_CV';
	
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventOfficer');

	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T1_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_Shuriken_MG_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'Shuriken_MG_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_throwingknife";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('Shuriken_CV');
	Template.ReferenceItemTemplate = 'Shuriken_MG';
	Template.HideIfPurchased = 'Shuriken_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	//Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T2_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.THROWING_KNIFE_T2_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_Shuriken_BM_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'Shuriken_BM_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_throwingknife";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 3;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('Shuriken_CV');
	Template.ItemsToUpgrade.AddItem('Shuriken_MG');
	Template.ReferenceItemTemplate = 'Shuriken_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	//Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.THROWING_KNIFE_T3_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.THROWING_KNIFE_T3_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = default.THROWING_KNIFE_T3_MAT2COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_SpecOpsKnife_CV_Schematic()
{	
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'SpecOpsKnife_CV_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_knife"; 
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;
	Template.HideIfPurchased = 'SpecOpsKnife_CV';
	Template.ReferenceItemTemplate = 'SpecOpsKnife_CV';
	
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.KNIFE_T1_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventOfficer');

	return Template;
}

static function X2DataTemplate CreateTemplate_SpecOpsKnife_MG_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'SpecOpsKnife_MG_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_Knife_MG";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('SpecOpsKnife_CV');
	Template.ReferenceItemTemplate = 'SpecOpsKnife_MG';
	Template.HideIfPurchased = 'SpecOpsKnife_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	//Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.KNIFE_T2_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.KNIFE_T2_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateTemplate_SpecOpsKnife_BM_Schematic()
{
	local X2SchematicTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'SpecOpsKnife_BM_Schematic');

	Template.ItemCat = 'weapon';
	Template.strImage = "img:///CombatKnifeMod.Textures.ui_Knife_bm";
	Template.CanBeBuilt = true;
	Template.bOneTimeBuild = true;
	Template.HideInInventory = true;
	Template.HideInLootRecovered = true;
	Template.PointsToComplete = 0;
	Template.Tier = 3;
	Template.OnBuiltFn = UpgradeItems;

	// Items to Upgrade
	Template.ItemsToUpgrade.AddItem('SpecOpsKnife_CV');
	Template.ItemsToUpgrade.AddItem('SpecOpsKnife_MG');
	Template.ReferenceItemTemplate = 'SpecOpsKnife_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	//Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.KNIFE_T3_RESCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = default.KNIFE_T3_MAT1COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = default.KNIFE_T3_MAT2COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function UpgradeItems(XComGameState NewGameState, XComGameState_Item ItemState)
{
	class'XComGameState_HeadquartersXCom'.static.UpgradeItems(NewGameState, ItemState.GetMyTemplateName());
}