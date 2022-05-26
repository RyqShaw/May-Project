extends "res://Battle/Cards/BaseCard/CardBase.gd"

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

func action():
	var battle = battleUnits.Battle
	if battle != null:
		var last_card = cardHandler.last_card
		cardHandler.append_last_card(last_card)
	
