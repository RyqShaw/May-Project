extends "res://Battle/Cards/BaseCard/CardBase.gd"

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	if enemy != null and player != null:
		for i in 5:
			if randf() < 0.75:
				print("hit")
				SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
				enemy.take_damage(4*player.damage_mod)
#				yield(get_tree().create_timer(0.1), "timeout")
