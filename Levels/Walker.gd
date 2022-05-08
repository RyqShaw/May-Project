extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT,Vector2.UP,Vector2.LEFT,Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = []
var steps_since_turn = 0
var rooms = []

#Initializing start position of walker, and border
func _init(start_pos, new_border):
	assert(new_border.has_point(start_pos))
	position = start_pos
	step_history.append(position)
	borders = new_border

#makes the walker progress and turn and records steps
func walk(steps):
	place_room(position)
	for step in steps:
		# adding randomness makes it slightly less uniform, if wanted randf() < 0.5 is good, and make it happen after 6 steps to make
		# Spaced out
		if steps_since_turn >= 8:
			change_direction()
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

#steps walker forward
func step():
	var target_pos = position + direction
	if borders.has_point(target_pos):
		steps_since_turn += 1
		position = target_pos
		return true
	else:
		return false

#grabs random direction, if at border grabs a different direction
func change_direction():
	place_room(position)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

# creates an array with room location and size of it
func create_room(position, size):
	return {position = position, size = size}

# places a room with a random size, finds position and size
func place_room(position):
	var size = Vector2(randi() % 4 + 4, randi() % 4 + 4)
	var top_left = (position - size/2).ceil()
	rooms.append(create_room(position,size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left + Vector2(x,y)
			if borders.has_point(new_step):
				step_history.append(new_step)

# finds room farthest from player in given rooms list
func get_end_room():
	var end_room = rooms.pop_front()
	var starting_position = step_history.front()
	for room in rooms:
		if starting_position.distance_to(room.position) > starting_position. distance_to(end_room.position):
			end_room = room
	return end_room
