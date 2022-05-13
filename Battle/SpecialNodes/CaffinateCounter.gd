extends "res://Battle/SpecialNodes/TurnCounter.gd"

func _ready(): last_turn = 3

func _on_CaffinateCounter_tree_entered():
	player.max_moves += 1

func _on_CaffinateCounter_tree_exited():
	player.max_moves -= 1
