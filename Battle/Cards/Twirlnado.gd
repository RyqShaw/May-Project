extends "res://Battle/Cards/BaseCard/CardBase.gd"

const shield = preload("res://Battle/SpecialNodes/RunningManCounter.tscn")

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	var battle = battleUnits.Battle
	if enemy != null and player != null:
		SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
		enemy.take_damage(4*player.damage_mod*player.damageDouble)
		player.damageDouble = 1
		player.resistance += 5
		var s = shield.instance()
		battle.get_node("PlayerCounters").add_child(s)
