extends KinematicBody2D

export var acceleration = 300
export var maxSpeed = 50
export var friction = 200
export var wanderTargetRange = 4

signal battleStarted

enum {
	IDLE,
	WANDER,
	FIGHT
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = FIGHT

onready var playerDetectionZone = $EnemyGaze/PlayerDetection
onready var wanderController = $WanderController

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
			
		FIGHT:
			var player = playerDetectionZone.player
			if player != null:
				emit_signal("battleStarted")
			else:
				state = IDLE

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = FIGHT

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
