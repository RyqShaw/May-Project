extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const weakIndicator = preload("res://Battle/Player/WeakenDebuff.tscn")
var debuff

func _ready(): last_turn = 2

func _on_DropItDownCounter_tree_entered():
	player.damage_mod = 1.5
	var indicator = weakIndicator.instance()
	battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
	debuff = indicator
	player.enemyWeakened = true

func _on_DropItDownCounter_tree_exited():
	player.enemyWeakened = false
	debuff.queue_free()
