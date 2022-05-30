extends "res://Battle/Cards/BaseCard/CardBase.gd"

func _ready():
	$Border/Name.rect_scale = $Border/Name.rect_scale/1.2

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	if enemy != null and player != null:
		for i in 4:
			if randf() < 0.75:
				SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
				enemy.take_damage(4*player.damage_mod)
#				yield(get_tree().create_timer(0.1), "timeout")
