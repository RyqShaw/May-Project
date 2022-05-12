extends AnimatedSprite

const player = preload("res://Battle/Player/PlayerStats.tres")

const max_bar = 50
var bar = max_bar setget set_bar

func _ready():
	player.connect("confidence_changed",self, "set_bar")
	set_bar(player.confidence)
	
func set_bar(value):
	$PlayerConfBar/TextureProgress.value = value
