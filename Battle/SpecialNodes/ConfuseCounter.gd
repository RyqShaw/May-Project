extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const confuseIndicator = preload("res://Battle/Player/DamageUp.tscn")
var enemy = battleUnits.Enemy
var buff

func _ready(): last_turn = 2

func _on_ConfuseCounter_tree_entered():
	if not enemy.confuseOn:
		var indicator = confuseIndicator.instance()
		battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
		buff = indicator
		enemy.confuseOn = true

func _on_ConfuseCounter_tree_exited():
	if enemy.confuseOn:
		enemy.confuseOn = false
		buff.queue_free()
