extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	var battle = battleUnits.Battle
	if battle != null:
		if randf() < 0.5:
			SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
			battle.naenae = true
		else:
			SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
		
