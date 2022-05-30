extends Node

const player = preload("res://Battle/Player/PlayerStats.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const shieldIndicator = preload("res://Battle/Player/FlatDmgReduction.tscn")
var buff

func _ready():
	player.connect("no_confidence", self, "on_Player_died")

func _on_WidenStanceSetter_tree_entered():
	player.default_resistance = 2
	player.resistance +=2
	if not player.shieldUp:
		var indicator = shieldIndicator.instance()
		indicator.get_node("Resistance").text = str(player.resistance)
		battleUnits.Battle.find_node("PlayerBuffs").add_child(indicator)
		buff = indicator
		player.shieldUp = true
	else:
		battleUnits.Battle.get_node("PlayerBuffs/FlatDmgReduction/Resistance").text = str(player.resistance)

func _on_WidenStanceSetter_tree_exited():
	player.default_resistance = 0
	player.resistance -=2
	if player.shieldUp and player.resistance <= 0:
		player.shieldUp = false
		buff.queue_free()
