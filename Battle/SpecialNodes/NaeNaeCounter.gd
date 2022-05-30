extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const naeNaeIndicator = preload("res://Battle/Player/DamageDown.tscn")
#temp indicator
var buff

func _ready(): last_turn = 1

func _on_NaeNaeCounter_tree_entered():
	var indicator = naeNaeIndicator.instance()
	battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
	buff = indicator

func _on_NaeNaeCounter_tree_exited():
	buff.queue_free()