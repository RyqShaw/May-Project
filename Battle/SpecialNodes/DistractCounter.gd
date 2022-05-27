extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const distractIndicator = preload()
var buff

func _ready(): last_turn = 1

func _on_DistractCounter_tree_entered():
	var indicator = distractIndicator.instance()
	battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
	buff = indicator
	player.max_moves -= 1

func _on_DistractCounter_tree_exited():
	player.max_moves += 1
	player.moves = player.max_moves
	buff.queue_free()
