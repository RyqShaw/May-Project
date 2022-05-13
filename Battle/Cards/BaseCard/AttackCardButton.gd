extends "res://Battle/Cards/BaseCard/CardButton.gd"

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	if enemy != null and player != null:
		enemy.take_damage(1)
