extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const stretchIndicator = preload("res://Battle/Player/caffineBuff.tscn")
var buff

func _ready(): last_turn = 1

func _on_StretchesCounter_tree_entered():
	var indicator = stretchIndicator.instance()
	battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
	buff = indicator

func _on_StretchesCounter_tree_exited():
	buff.queue_free()
