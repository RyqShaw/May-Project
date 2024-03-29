extends KinematicBody2D

export var acceleration = 500
export var maxSpeed = 110
export var friction = 500

var velocity = Vector2.ZERO

onready var sprite = $AnimatedSprite

func _ready():
	$RichTextLabel.text = "Floor: " + str(GlobalInfo.rooms)
	update_deck_label()
	GlobalInfo.connect("deck_changed",self,"update_deck_label")

func _physics_process(delta):
	
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		if $WalkSound.playing == false: $WalkSound.playing = true
		velocity = velocity.move_toward(inputVector * maxSpeed, acceleration * delta)
		sprite.set_animation("Walk")
		sprite.flip_h = velocity.x < 0
	else:
		if $WalkSound.playing == true: $WalkSound.playing = false
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		sprite.set_animation("Idle")
	
	velocity = move_and_slide(velocity)

func update_deck_label():
	$'Deck Size'.text = "Deck Size: " + str(GlobalInfo.deckSize)
