extends "res://Battle/Cards/BaseCard/CardBase.gd"

const dropItDown = preload("res://Battle/SpecialNodes/DropItDownCounter.tscn")

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	var battle = battleUnits.Battle
	if enemy != null and player != null:
		SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
		enemy.take_damage(5*player.damage_mod)
		var d = dropItDown.instance()
		battle.get_node("PlayerCounters").add_child(d)
