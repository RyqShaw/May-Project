extends AnimatedSprite

const player = preload("res://Battle/Player/PlayerStats.tres")

const max_bar = 56
var bar = max_bar setget set_bar

onready var confidence = $PlayerConfBar/Filling

func _ready():
	player.connect("confidence_changed",self, "set_bar")
	
func set_bar(value):
	bar = clamp(value, 0, max_bar)
	if confidence != null:
		confidence.rect_size.x = player.confidence * (max_bar/player.max_confidence)
	if player.confidence == player.max_confidence:
		confidence.rect_size.x = max_bar