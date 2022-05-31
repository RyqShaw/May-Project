extends "res://Battle/SpecialNodes/EnemyTurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const bounceIndicator = preload("res://Battle/Player/DamageDown.tscn")
var debuff

func _ready(): last_turn = 1

func _on_BounceCounter_tree_entered():
	var indicator = bounceIndicator.instance()
	battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
	debuff = indicator
  
func _on_BounceCounter_tree_exited():
	debuff.queue_free()
