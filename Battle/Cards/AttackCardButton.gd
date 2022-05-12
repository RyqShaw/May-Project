extends "res://Battle/Cards/CardButton.gd"

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.PlayerStats
	if enemy != null and player != null:
		enemy.take_damage(1)
