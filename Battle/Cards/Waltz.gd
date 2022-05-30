extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	var player = battleUnits.Player
	var enemy = battleUnits.Enemy
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		enemy.setDmgBoost(2)
