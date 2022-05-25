extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const stretchIndicator = preload("res://Battle/Player/DamageUp.tscn")
var buff

func _ready(): last_turn = 1

func _on_StretchesCounter_tree_entered():
	if not player.damageUp:
		var indicator = stretchIndicator.instance()
		battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
		buff = indicator
		player.damageUp = true

func _on_StretchesCounter_tree_exited():
	if player.damageUp:
		player.damageUp = false
		buff.queue_free()
