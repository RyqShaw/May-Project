extends "res://Battle/Cards/BaseCard/CardBase.gd"

const shield = preload("res://Battle/SpecialNodes/RunningManCounter.tscn")

func _ready():
	$Border/Name.rect_scale = $Border/Name.rect_scale/1.2
	

func action():
	var enemy = battleUnits.Enemy
	var player = battleUnits.Player
	var battle = battleUnits.Battle
	if enemy != null and player != null:
		SoundManager.play_sound(load("res://SoundAffects/powerUp.wav"))
		player.resistance += 8
		var s = shield.instance()
		battle.get_node("PlayerCounters").add_child(s)
