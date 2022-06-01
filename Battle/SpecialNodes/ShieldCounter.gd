extends "res://Battle/SpecialNodes/EnemyTurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const shieldIndicator = preload("res://Battle/Player/FlatDmgReduction.tscn")
var buff

func _ready(): last_turn = 1

func _on_ShieldCounter_tree_entered():
	if not battleUnits.Enemy.shieldUp:
		var indicator = shieldIndicator.instance()
		indicator.get_node("Resistance").text = str(4)
		battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
		buff = indicator
		battleUnits.Enemy.shieldUp = true

func _on_ShieldCounter_tree_exited():
	if battleUnits.Enemy != null:
		if battleUnits.Enemy.shieldUp:
			battleUnits.Enemy.shieldUp = false
			if buff != null: buff.queue_free()
