extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const chaChaIndicator = preload("res://Battle/Player/DamageDown.tscn")
var enemy = battleUnits.Enemy
var buff

func _ready(): last_turn = 2

func _on_ChaChaCounter_tree_entered():
	if not player.enemyDmgDown:
		var indicator = chaChaIndicator.instance()
		battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
		buff = indicator
		enemy.setOtherDamageMod(0.7)
		player.enemyDmgDown = true

func _on_ChaChaCounter_tree_exited():
	var enemy  = battleUnits.Enemy
	if player.enemyDmgDown and enemy != null:
		enemy.setOtherDamageMod(1.0)
		player.enemyDmgDown = false
		buff.queue_free()
