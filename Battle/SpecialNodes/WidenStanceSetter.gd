extends Node

const player = preload("res://Battle/Player/PlayerStats.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

func _ready():
	player.connect("no_confidence", self, "on_Player_died")

func _on_WidenStanceSetter_tree_entered():
	player.default_resistance = 2
	player.resistance +=2

func _on_WidenStanceSetter_tree_exited():
	player.default_resistance = 0
	player.resistance -=2
