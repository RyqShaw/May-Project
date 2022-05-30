extends "res://Battle/Cards/BaseCard/CardBase.gd"

func _ready():
	$Border/Name.rect_scale = $Border/Name.rect_scale/1.5
	

func action():
	var player = battleUnits.Player
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		player.confidence += 15
