extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const player = preload("res://Battle/Player/PlayerStats.tres")

var turn = 0
var last_turn = 0

func _ready():
	turnManager.connect("player_turn_started", self, "_iterate_counter")
	player.connect("no_confidence", self, "on_Player_died")

func _iterate_counter():
	turn += 1
	if turn >= last_turn: queue_free()

func on_Player_died():
	queue_free()
