extends Resource
class_name PlayerStats

export var max_confidence = 1 setget set_max_confidence
var confidence = max_confidence setget set_confidence
export var speed = 1 setget set_speed
export var max_moves = 1 setget set_max_moves
var moves = max_moves setget set_moves

signal no_confidence
signal confidence_changed
signal max_confidence_changed

func set_max_confidence(value):
	max_confidence = value
	self.confidence = min(max_confidence, max_confidence)
	emit_signal("max_confidence_changed", max_confidence)

func set_confidence(value):
	confidence = clamp(value, 0, max_confidence)
	emit_signal("confidence_changed", confidence)
	if confidence <=0:
		emit_signal("no_confidence")

func set_speed(value):
	speed = value
	
func set_moves(value):
	moves = clamp(value, 0, max_moves)

func set_max_moves(value):
	max_moves = value
	self.moves = min(max_moves, max_moves)

func _ready():
	self.confidence = max_confidence
