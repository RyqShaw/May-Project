extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	var battle = battleUnits.Battle
	if battle != null:
		battle.append_last_card()
	
