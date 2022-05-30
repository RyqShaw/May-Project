extends "res://Battle/Cards/BaseCard/CardBase.gd"

const waltzIndicator = preload("res://Battle/Player/WaltzBuff.tscn")
var buff

func action():
	var player = battleUnits.Player
	var enemy = battleUnits.Enemy
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		enemy.setDmgBoost(2)
		var indicator = waltzIndicator.instance()
		battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
		buff = indicator
