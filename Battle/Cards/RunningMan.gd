extends "res://Battle/Cards/BaseCard/CardBase.gd"

func _ready():
	$Border/Name.rect_scale = $Border/Name.rect_scale/1.2

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	if enemy != null and player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		player.resistance = 8
