extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const shieldIndicator = preload("res://Battle/Player/FlatDmgReduction.tscn")
var enemy = battleUnits.Enemy
var buff

func _ready(): last_turn = 2

func _on_ShieldCounter_tree_entered():
	if not enemy.shieldUp:
		var indicator = shieldIndicator.instance()
		indicator.get_node("Resistance").text = str(4)
		battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
		buff = indicator
		enemy.shieldUp = true

func _on_ShieldCounter_tree_exited():
	if enemy.shieldUp:
		enemy.shieldUp = false
		buff.queue_free()
