extends "res://Battle/SpecialNodes/EnemyTurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const confuseIndicator = preload("res://Battle/Player/DamageUp.tscn")
var buff

func _ready(): last_turn = 1

func _on_ConfuseCounter_tree_entered():
	if not battleUnits.Enemy.confuseOn:
		var indicator = confuseIndicator.instance()
		battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
		buff = indicator
		battleUnits.Enemy.confuseOn = true

func _on_ConfuseCounter_tree_exited():
	if battleUnits.Enemy.confuseOn:
		battleUnits.Enemy.confuseOn = false
		buff.queue_free()
