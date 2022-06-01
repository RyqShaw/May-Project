extends "res://Battle/SpecialNodes/TurnCounter.gd"

const battleUnits = preload("res://Battle/BattleUnits.tres")
const playerStats = preload("res://Battle/Player/PlayerStats.tres")
const shieldIndicator = preload("res://Battle/Player/FlatDmgReduction.tscn")
var buff

func _ready(): last_turn = 1

func _on_WidenCounter_tree_entered():
	yield(get_tree().create_timer(0.3), "timeout")
	if not player.shieldUp or not player.widenTrue:
		var indicator = shieldIndicator.instance()
		indicator.get_node("Resistance").text = str(playerStats.resistance)
		battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
		buff = indicator
		player.shieldUp = true
		player.widenTrue = true
	else:
		battleUnits.Battle.get_node("PlayerBuffs/FlatDmgReduction/Resistance").text = str(playerStats.resistance)

func _on_WidenCounter_tree_exited():
	if buff != null: buff.queue_free()
	battleUnits.Battle.get_node("PlayerBuffs/FlatDmgReduction/Resistance").text = str(playerStats.resistance)
	if player.shieldUp and player.resistance == 0:
		player.shieldUp = false
	player.widenTrue = false
