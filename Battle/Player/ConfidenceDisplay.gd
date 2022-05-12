extends Label

const player = preload("res://Battle/Player/PlayerStats.tres")

func _ready():
	player.connect("confidence_changed", self, "_confidence_changed")
	text = str(player.confidence) + " confidence"
	
func _confidence_changed(val):
	text = str(val) + " confidence"
