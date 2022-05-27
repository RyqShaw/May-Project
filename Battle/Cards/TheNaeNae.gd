extends "res://Battle/Cards/BaseCard/CardBase.gd"

const naeNaeCount = preload("res://Battle/SpecialNodes/DistractCounter.tscn")

func action():
	var battle = battleUnits.Battle
	if battle != null:
		if randf() < 0.5:
			SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
			battle.naenae = true
			var c = naeNaeCount.instance()
			battle.get_node("PlayerCounters").add_child(c)
		else:
			SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
