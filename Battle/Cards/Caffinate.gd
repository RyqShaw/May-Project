extends "res://Battle/Cards/BaseCard/CardButton.gd"

const caffinate = preload("res://Battle/SpecialNodes/CaffinateCounter.tscn")

func action():
	var player = battleUnits.Player
	var battle = battleUnits.Battle
	if battle != null:
		var c = caffinate.instance()
		battle.add_child(c)
