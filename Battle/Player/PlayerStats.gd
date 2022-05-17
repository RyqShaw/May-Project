extends Resource
class_name PlayerStats

const turnManager = preload("res://Battle/TurnManager.tres")

export var max_confidence = 50 setget set_max_confidence
var confidence = max_confidence setget set_confidence

export var max_moves = 3 setget set_max_moves
var moves = max_moves setget set_moves

export var default_resistance = 0
var resistance = default_resistance
export var default_damage_mod = 1
var damage_mod = default_resistance

signal no_confidence()
signal confidence_changed(value)
signal max_confidence_changed()

signal speed_changed(value)
signal moves_changed(value)

func set_max_confidence(value):
	max_confidence = value
	self.confidence = min(max_confidence, max_confidence)
	emit_signal("max_confidence_changed", max_confidence)

func set_confidence(value):
	confidence = clamp(value, 0, max_confidence)
	emit_signal("confidence_changed", confidence)
	
func set_moves(value):
	moves = clamp(value, 0, max_moves)
	emit_signal("moves_changed", moves)

func set_max_moves(value):
	max_moves = value
#	self.moves = min(max_moves, max_moves)

func _ready():
	self.confidence = max_confidence
