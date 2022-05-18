extends Node2D

const Player = preload("res://Player/Player.tscn")
const Exit = preload("res://Levels/ExitDoor.tscn")
const Enemy = preload("res://Enemies/BasicEnemy.tscn")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

# Borders, makes it 1 tile border, makes 38 long and 21 high room to choose from
var borders = Rect2(1,1,100,50)

onready var tileMap = $TileMap

func _ready():
	if cardHandler.deck == []: cardHandler.init_starter()
	randomize()
	generate_level()
	$CanvasLayer/FadeAnimator.play("Fade")

# Creates Walker, makes it walk and takes step history, sets tile map cells to delete at positions recorded
func generate_level():
	var walker = Walker.new(Vector2(50,25),borders)
	var map = walker.walk(300)
	var rooms = walker.get_rooms()
	
	var player = Player.instance()
	add_child(player)
	player.position = map.pop_front() * 32
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position * 32 #depending on if distance from exit or whatever object being generated matters, get_end_room can be replaced with rooms.back()
	exit.connect("leaving_level", self, "reload_level")
	
	# Enemy Generation
	for i in rooms:
		if randf() < 0.60:
			var enemy = Enemy.instance()
			add_child(enemy)
			enemy.position = walker.get_room().position * 32
			if player.position.distance_to(enemy.position) <= 32 or exit.position.distance_to(enemy.position) <= 32:
				enemy.free()
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
		#Random Objects?
#		if randf() < 0.025:
#			var object = Player.instance()
#			add_child(object)
#			object.position = location * 32
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	GlobalInfo.rooms += 1
	get_tree().reload_current_scene()
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		get_tree().reload_current_scene()
