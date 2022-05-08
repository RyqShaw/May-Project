extends Node2D

# const Player = preload("res://Player.tscn")
# const Exit = preload("res://ExitDoor.tscn")

# Borders, makes it 1 tile border, makes 38 long and 21 high room to choose from
var borders = Rect2(2,2,77,45)

onready var tileMap = $TileMap

func _ready():
	randomize()
	generate_level()

# Creates Walker, makes it walk and takes step history, sets tile map cells to delete at positions recorded
func generate_level():
	var walker = Walker.new(Vector2(38,22),borders)
	var map = walker.walk(400)
	
	# var player = Player.instance()
	#add_child(player)
	#player.position = map.front() * 32
	
	#var exit = Exit.instance()
	#add_child(exit)
	#exit.position = walker.get_end_room().position * 32 #depending on if distance from exit or whatever object being generated matters, get_end_room can be replaced with rooms.back()
	#exit.connect("leaving_level", self, "reload_level")
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
