extends "res://Battle/Cards/CardButton.gd"

func _on_CardButton_pressed():
	var enemy = battleUnits.Enemy
	var player = battleUnits.PlayerStats
	if enemy != null and player != null:
		enemy.take_damage(1)
		player.moves -= 1
