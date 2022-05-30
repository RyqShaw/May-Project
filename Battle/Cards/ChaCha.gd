extends "res://Battle/Cards/BaseCard/CardBase.gd"

const chaCha = preload("res://Battle/SpecialNodes/ChaChaCounter.tscn")

func action():
	var player = battleUnits.Player
	var battle = battleUnits.Battle
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		var c = chaCha.instance()
		battle.get_node("PlayerCounters").add_child(c)
