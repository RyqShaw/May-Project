extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const caffineIndicator = preload("res://Battle/Player/caffineBuff.tscn")
var buff

func _ready(): last_turn = 4

func _on_CaffinateCounter_tree_entered():
	player.max_moves += 1
	var indicator = caffineIndicator.instance()
	battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
	buff = indicator

func _on_CaffinateCounter_tree_exited():
	player.max_moves -= 1
	player.moves = player.max_moves
	if buff != null: buff.queue_free()
