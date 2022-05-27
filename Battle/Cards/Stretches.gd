extends "res://Battle/Cards/BaseCard/CardBase.gd"

const stretch = preload("res://Battle/SpecialNodes/StretchesCounter.tscn")

func action():
	var player = battleUnits.Player
	var battle = battleUnits.Battle
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		if player.enemyWeakened == false:
			player.damage_mod = 1.5
		var c = stretch.instance()
		battle.get_node("PlayerCounters").add_child(c)
