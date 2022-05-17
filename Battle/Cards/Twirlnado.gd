extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	if enemy != null and player != null:
		SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
		enemy.take_damage(4*player.damage_mod)
		player.resistance = 5
