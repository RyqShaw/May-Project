extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

export(Array, PackedScene) var deck = []

onready var buttons = $UI/Cards

func _ready():
	buttons.hide()
	var player = battleUnits.PlayerStats
	
	turnManager.connect("player_turn_started",self,"_player_turn_started")
	turnManager.connect("enemy_turn_started",self,"_enemy_turn_started")
	player.connect("no_confidence", self, "on_Player_died")
	create_hand()
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

func create_hand():
	for i in 7:
		var card = deck.pop_front().instance()
		get_tree().get_root().get_node("Battle/UI/Cards").add_child(card)
		deck.append(load("res://Battle/Cards/CardButton.tscn").instance())
	print(deck)

func on_Player_died():
#	$Player.queue_free()
#	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
