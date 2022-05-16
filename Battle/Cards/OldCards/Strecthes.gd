extends "res://Battle/Cards/BaseCard/CardButton.gd"

func action():
	var player = battleUnits.Player
	if player != null:
		player.damage_mod = 1.25
