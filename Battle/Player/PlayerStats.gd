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

signal lower_conf
signal higher_conf

signal max_moves_changed
signal moves_changed

func set_max_confidence(value):
	max_confidence = value
	self.confidence = min(max_confidence, max_confidence)
	emit_signal("max_confidence_changed", max_confidence)

func set_confidence(value):
	if confidence > value:
		emit_signal("lower_conf")
	if confidence < value:
		emit_signal("higher_conf")
		
	confidence = clamp(value, 0, max_confidence)
	emit_signal("confidence_changed", confidence)
	
func set_moves(value):
	moves = clamp(value, 0, max_moves)
	emit_signal("moves_changed")

func set_max_moves(value):
	max_moves = value
	emit_signal("max_moves_changed")

func _ready():
	self.confidence = max_confidence
