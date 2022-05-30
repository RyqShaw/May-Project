extends "res://Battle/Cards/BaseCard/CardBase.gd"

func _ready():
	$Border/Name.rect_scale = $Border/Name.rect_scale/1.2

func action():
	var player = battleUnits.Player
	var battle = battleUnits.Battle
	if player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		player.damageDouble = 2
