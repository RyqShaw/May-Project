extends "res://Battle/Cards/BaseCard/CardBase.gd"

const caffinate = preload("res://Battle/SpecialNodes/CaffinateCounter.tscn")

func action():
	var battle = battleUnits.Battle
	if battle != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		var c = caffinate.instance()
		battle.get_node("PlayerCounters").add_child(c)
