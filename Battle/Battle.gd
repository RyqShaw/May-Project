extends Node

const player = preload("res://Battle/Player/PlayerStats.tres")
const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

onready var buttons = $UI/Cards

func _ready():
	buttons.hide()
	
	turnManager.connect("player_turn_started",self,"_player_turn_started")
	turnManager.connect("enemy_turn_started",self,"_enemy_turn_started")
	player.connect("no_confidence", self, "on_Player_died")
	turnManager.turn = turnManager.PLAYER_TURN

func _player_turn_started():
	print("Player Turn Started")
	print(battleUnits.PlayerStats.confidence)
	buttons.show()
	var player = battleUnits.PlayerStats
	player.moves = player.max_moves

func _enemy_turn_started():
	print("Enemy Turn Started")
	buttons.hide()
	var enemy = battleUnits.Enemy
	if enemy != null:
		enemy.attack()

func on_Player_died():
#	$Player.queue_free()
#	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
