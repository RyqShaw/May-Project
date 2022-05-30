extends "res://Battle/Cards/BaseCard/CardBase.gd"

const widen = preload("res://Battle/SpecialNodes/WidenStanceSetter.tscn")
var buff

func action():
	var player = battleUnits.Player
	var enemy = battleUnits.Enemy
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		var indicator = widen.instance()
		battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
		buff = indicator
