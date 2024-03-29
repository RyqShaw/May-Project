extends KinematicBody2D

export var acceleration = 300
export var maxSpeed = 55
export var friction = 200
export var wanderTargetRange = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = CHASE

var inWall = false

onready var playerDetectionZone = $PlayerDetection
onready var wanderController = $WanderController
onready var sightZone = $SightZone

func _ready():
	state = pick_random_state([WANDER, IDLE])

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= wanderTargetRange:
				update_wander()
			
		CHASE:
			var player = sightZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	if velocity.x > 0: $Sprite.flip_h = true
	else: $Sprite.flip_h = false
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func _on_InWall_body_entered(body):
	inWall = true
