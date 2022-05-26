extends "res://Battle/Cards/BaseCard/CardBase.gd"

func _ready():
	$Border/Name.rect_scale = $Border/Name.rect_scale/1.5

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	if enemy != null and player != null:
		player.resistance = 8
