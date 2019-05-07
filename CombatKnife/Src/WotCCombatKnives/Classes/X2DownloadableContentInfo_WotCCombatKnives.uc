class X2DownloadableContentInfo_WotCCombatKnives extends X2DownloadableContentInfo config (CombatKnifeMod);

struct SocketReplacementInfo
{
	var name TorsoName;
	var string SocketMeshString;
	var bool Female;
};

var config array<SocketReplacementInfo> SocketReplacements;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager  TemplateManager;
	local X2AbilityTemplate         Template;
	local Array<name>				TemplateNames;
	local Array<name>				ExcludeTemplateNames;
	local name						TemplateName;
	local Musashi_AbilityCooldown	MusashiCooldown;

	TemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	TemplateNames.AddItem('SilentTakedown');
	TemplateNames.AddItem('SilentTakedown');
	TemplateNames.AddItem('SilentTakedown');
	TemplateNames.AddItem('MusashiNinjatoSilentTakedownT1');
	TemplateNames.AddItem('MusashiNinjatoSilentTakedownT2');
	TemplateNames.AddItem('MusashiNinjatoSilentTakedownT3');

	foreach TemplateNames(TemplateName)
	{
		Template = TemplateManager.FindAbilityTemplate(TemplateName);
		if (Template != none)
		{
			`LOG("Musashi patching Template :" @ TemplateName @ "with Musashi_AbilityCooldown",, 'CombatKnife');
			MusashiCooldown = new class'Musashi_AbilityCooldown';
			MusashiCooldown.iNumTurns = Template.AbilityCooldown.iNumTurns;
			MusashiCooldown.AddAbilityBonusCooldown('MusashiKnifeSpecialistCooldown', class'Musashi_CK_AbilitySet'.default.KNIFE_SPECIALIST_COOLDOWN);
			Template.AbilityCooldown = MusashiCooldown;
		}
	}
}


/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{
	`Log("Musashi CombatKnife : Starting OnLoadedSavedGame",, 'CombatKnife');

	UpdateStorage();
	
}

// ******** HANDLE UPDATING STORAGE ************* //
static function UpdateStorage()
{
	local XComGameState NewGameState;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateMgr;
	local array<X2ItemTemplate> ItemTemplates;
	local XComGameState_Item NewItemState;
	local int i;

	History = `XCOMHISTORY;
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Updating HQ Storage to add CombatKnife");
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	NewGameState.AddStateObject(XComHQ);
	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplates.AddItem(ItemTemplateMgr.FindItemTemplate('SpecOpsKnife_CV'));
	ItemTemplates.AddItem(ItemTemplateMgr.FindItemTemplate('ThrowingKnife_CV_Secondary'));
	for (i = 0; i < ItemTemplates.Length; ++i)
	{
		if(ItemTemplates[i] != none)
		{
			if (!XComHQ.HasItem(ItemTemplates[i]))
			{
				`Log(ItemTemplates[i].GetItemFriendlyName() @ " not found, adding to inventory",, 'CombatKnife');
				NewItemState = ItemTemplates[i].CreateInstanceFromTemplate(NewGameState);
				NewGameState.AddStateObject(NewItemState);
				XComHQ.AddItemToHQInventory(NewItemState);
			} else {
				`Log(ItemTemplates[i].GetItemFriendlyName() @ " found, skipping inventory add",, 'CombatKnife');
			}
		}
	}

	History.AddGameStateToHistory(NewGameState);
}

static function bool IsModInstalled(string DLCIdentifier)
{
	local X2DownloadableContentInfo Mod;
	local name DLCInfoName;

	foreach `ONLINEEVENTMGR.m_cachedDLCInfos (Mod)
	{
		DLCInfoName = name("X2DownloadableContentInfo_" $ DLCIdentifier);

		//`Log("Mod found:" @ Mod.DLCIdentifier  @ "[" $ Mod.Class.Name $ "]");

		if (Mod.DLCIdentifier == DLCIdentifier)
		{
			`Log("Mod installed:" @ DLCIdentifier);
			return true;
		}

		if (Mod.Class.Name == DLCInfoName)
		{
			`Log("Mod installed:" @ DLCInfoName);
			return true;
		}
	}

	`Log("Mod not found:" @ DLCIdentifier);
	return false;
}

static function string DLCAppendSockets(XComUnitPawn Pawn)
{
	local SocketReplacementInfo SocketReplacement;
	local name TorsoName;
	local bool bIsFemale;
	local string DefaultString, ReturnString;
	local XComHumanPawn HumanPawn;

	//`LOG("DLCAppendSockets" @ Pawn,, 'SpecOpsKnifes');

	HumanPawn = XComHumanPawn(Pawn);
	if (HumanPawn == none) { return ""; }

	TorsoName = HumanPawn.m_kAppearance.nmTorso;
	bIsFemale = HumanPawn.m_kAppearance.iGender == eGender_Female;

	//`LOG("DLCAppendSockets: Torso= " $ TorsoName $ ", Female= " $ string(bIsFemale),, 'SpecOpsKnifes');

	foreach default.SocketReplacements(SocketReplacement)
	{
		if (TorsoName != 'None' && TorsoName == SocketReplacement.TorsoName && bIsFemale == SocketReplacement.Female)
		{
			ReturnString = SocketReplacement.SocketMeshString;
			break;
		}
		else
		{
			if (SocketReplacement.TorsoName == 'Default' && SocketReplacement.Female == bIsFemale)
			{
				DefaultString = SocketReplacement.SocketMeshString;
			}
		}
	}
	if (ReturnString == "")
	{
		// did not find, so use default
		ReturnString = DefaultString;
	}
	//`LOG("Returning mesh string: " $ ReturnString,, 'SpecOpsKnifes');

	return ReturnString;
}