extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const enemy = preload("res://Battle/Enemy/Enemy.tscn")

var turn = 0
var last_turn = 0

func _ready():
	turnManager.connect("enemy_turn_started", self, "_iterate_counter")
	enemy.connect("on_death", self, "_on_Enemy_on_death")

func _iterate_counter():
	print("counting")
	turn += 1
	if turn >= last_turn: queue_free()

func _on_Enemy_on_death():
	print("hi")
	queue_free()
