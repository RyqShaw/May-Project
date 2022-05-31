extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
