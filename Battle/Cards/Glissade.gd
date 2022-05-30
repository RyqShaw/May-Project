extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	var player = battleUnits.Player
	var enemy = battleUnits.Enemy
	var battle = battleUnits.Battle
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		enemy.take_damage((5+battle.glissadeDamage)*player.damage_mod*player.damageDouble)
		player.damageDouble = 1
		battle.glissadeDamage += 2
