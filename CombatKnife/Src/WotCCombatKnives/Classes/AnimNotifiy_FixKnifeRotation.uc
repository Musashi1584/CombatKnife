class AnimNotifiy_FixKnifeRotation extends AnimNotify_Scripted;

var() bool bReset;

event Notify(Actor Owner, AnimNodeSequence AnimSeqInstigator)
{
	local XComUnitPawn Pawn;
	local XComGameState_Unit UnitState;

	// i use the disgnated socket KinefSheath now so no need for rotation manually anymore
	return;

	Pawn = XComUnitPawn(Owner);
	if (Pawn != none)
	{
		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Pawn.ObjectID));
		if (UnitState != none)
		{
			if (bReset)
			{
				SetMeshRotation(UnitState, 0);
			}
			else
			{
				SetMeshRotation(UnitState, 10924);
			}
		}
	}
	super.Notify(Owner, AnimSeqInstigator);
}

static function SetMeshRotation(XComGameState_Unit UnitState, int Pitch)
{
	local XComGameState_Item WeaponItem;
	local XGWeapon LocWeaponVisualizer;
	local XComWeapon Entity;
	local rotator NewRotation;

	if (UnitState != none) {
	
		WeaponItem = UnitState.GetSecondaryWeapon();

		if(
		   WeaponItem.GetMyTemplateName() == 'SpecOpsKnife_CV' ||
		   WeaponItem.GetMyTemplateName() == 'SpecOpsKnife_MG' ||
		   WeaponItem.GetMyTemplateName() == 'SpecOpsKnife_BM'
		)
		{
			LocWeaponVisualizer = XGWeapon(WeaponItem.GetVisualizer());
			Entity = LocWeaponVisualizer.GetEntity();
			
			NewRotation.Pitch = Pitch;
			
			Entity.Mesh.SetRotation(NewRotation);
			//`LOG("New rotation:" @ NewRotation,, 'CombatKnife'););
		}
	}
}