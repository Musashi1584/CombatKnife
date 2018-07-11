Class X2Ability_DefaultAbilitySet_BackstabOverwrite extends X2Ability_DefaultAbilitySet;

struct TemplateDelegate {
	var name TemplateName;
	var delegate<X2AbilityTemplate.BuildVisualizationDelegate> BuildVisualizationFn;
};

var config array<TemplateDelegate> TemplateDelegates;

simulated static function PatchMeleeAbilitiesWithBackstabVisualisationFN()
{
	local X2AbilityTemplateManager	TemplateManager;
	local X2AbilityTemplate			Template;
	local Array<name>				TemplateNames;
	local name						TemplateName;
	local TemplateDelegate			TempDelegate;
	TemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	
	TemplateManager.GetTemplateNames(TemplateNames);

	foreach TemplateNames(TemplateName)
	{
		Template = TemplateManager.FindAbilityTemplate(TemplateName);

		if (Template != none &&
			Template.IsMelee() &&
			Template.BuildVisualizationFn != none &&
			Template.DataName != 'DualSlashSecondary' &&
			InStr(String(Template.BuildVisualizationFn), "Backstab_BuildVisualization") == INDEX_NONE
			)
		{
			TempDelegate.TemplateName = TemplateName;
			TempDelegate.BuildVisualizationFn = Template.BuildVisualizationFn;
			default.TemplateDelegates.AddItem(TempDelegate);
			Template.BuildVisualizationFn = Backstab_BuildVisualization;
			`LOG("Overwrite BuildVisualizationFn with Backstab_BuildVisualization for" @ TemplateName ,,'Backstab');
		}
	}
}


simulated function Backstab_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateContext Context;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit SourceUnitState, TargetUnitState;
	local X2Action_MoveTurn MoveTurnAction;
	local int DelegateIndex, ActionIndex, ChildActionIndex;
	local UnitValue SilentMelee;
	local delegate<X2AbilityTemplate.BuildVisualizationDelegate> OriginalBuildVisualizationFn;
	local XComGameStateVisualizationMgr VisMgr;
	local array<X2Action> Nodes;
	
	VisMgr = `XCOMVISUALIZATIONMGR;
	Context = VisualizeGameState.GetContext();
	AbilityContext = XComGameStateContext_Ability(Context);
	SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	TargetUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));

	DelegateIndex = default.TemplateDelegates.Find('TemplateName', AbilityContext.InputContext.AbilityTemplateName);
	
	if (DelegateIndex != INDEX_NONE)
	{
		OriginalBuildVisualizationFn = default.TemplateDelegates[DelegateIndex].BuildVisualizationFn;
		OriginalBuildVisualizationFn(VisualizeGameState);
	}
	if (SourceUnitState == none || TargetUnitState == none)
		return;
	
	SourceUnitState.GetUnitValue('SilentMelee', SilentMelee);
	
	if (SilentMelee.fValue == 0)
		return;

	// Remove the MoveTurn action from the target in silent melee
	VisMgr.GetNodesOfType(VisMgr.BuildVisTree, class'X2Action_MoveTurn', Nodes, TargetUnitState.GetVisualizer());
	for(ActionIndex = 0; ActionIndex < Nodes.Length; ++ActionIndex)
	{
		if (Nodes[ActionIndex] != none)
		{
			VisMgr.DisconnectAction(Nodes[ActionIndex]);

			// Reparent childs
			for(ChildActionIndex = 0; ChildActionIndex < Nodes[ActionIndex].ChildActions.Length; ++ChildActionIndex)
			{
				if (Nodes[ActionIndex].ChildActions[ChildActionIndex] != none)
				{
					`LOG(GetFuncName() @ Nodes[ActionIndex] @ Nodes[ActionIndex].ChildActions[ChildActionIndex],, 'CombatKnife');
					VisMgr.DisconnectAction(Nodes[ActionIndex].ChildActions[ChildActionIndex]);
					VisMgr.ConnectAction(Nodes[ActionIndex].ChildActions[ChildActionIndex], VisMgr.BuildVisTree, false, none, Nodes[ActionIndex].ParentActions);
				}
			}
		}
	}
}