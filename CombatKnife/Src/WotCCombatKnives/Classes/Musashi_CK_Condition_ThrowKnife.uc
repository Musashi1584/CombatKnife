class Musashi_CK_Condition_ThrowKnife extends X2Condition;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource) 
{
	local XComGameState_Unit UnitState;
	local UnitValue          ThrowedKnifeThisTurn;

	UnitState = XComGameState_Unit(kTarget);
	if (UnitState != none)
	{
		UnitState.GetUnitValue('ThrowedKnifeThisTurn', ThrowedKnifeThisTurn);
		if(ThrowedKnifeThisTurn.fValue == 0)
		{
			return 'AA_Success';
		}
	}

	return 'AA_NoTargets';
}