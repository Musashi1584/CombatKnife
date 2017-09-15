class X2AbilityCost_ThrowingKnifeQuickdrawActionPoints extends X2AbilityCost_ActionPoints;

simulated function bool ConsumeAllPoints(XComGameState_Ability AbilityState, XComGameState_Unit AbilityOwner)
{
	if (AbilityOwner.HasSoldierAbility('ThrowingKnifeQuickdraw') && AbilityState.GetSourceWeapon().InventorySlot == eInvSlot_SecondaryWeapon)
	{
		return false;
	}
	return super.ConsumeAllPoints(AbilityState, AbilityOwner);
}