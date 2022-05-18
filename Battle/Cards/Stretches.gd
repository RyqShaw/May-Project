extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	var player = battleUnits.Player
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		player.damage_mod = 1.25
