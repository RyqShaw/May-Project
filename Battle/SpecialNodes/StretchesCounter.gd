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
		if player.enemyWeakened == false:
			player.damage_mod = 1.5
		player.damageUp = true

func _on_StretchesCounter_tree_exited():
	if player.damageUp:
		if player.enemyWeakened == false:
			player.damage_mod = 1.0
		player.damageUp = false
		buff.queue_free()
