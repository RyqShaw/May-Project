extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const distractIndicator = preload("res://Battle/Player/DamageDown.tscn")
#temp indicator
var buff

func _ready(): last_turn = 1

func _on_DistractCounter_tree_entered():
	var indicator = distractIndicator.instance()
	battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
	buff = indicator
	player.max_moves -= 1

func _on_DistractCounter_tree_exited():
	player.max_moves += 1
	if buff != null: buff.queue_free()
