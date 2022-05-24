extends AnimatedSprite

const player = preload("res://Battle/Player/PlayerStats.tres")

const max_bar = 50
var bar = max_bar setget set_bar

func _ready():
	player.connect("confidence_changed",self, "set_bar")
	player.connect("lower_conf",self, "blink")
	set_bar(player.confidence)
	
func set_bar(value):
	$PlayerConfBar/TextureProgress.value = value
	$Health.text = str(player.confidence) +"/"+ str(player.max_confidence)

func blink():
	$HitAnimation.play("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	$HitAnimation.stop()
	$HitAnimation.play("RESET")
