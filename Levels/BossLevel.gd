extends Node2D

onready var exit = $ExitDoor
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

func _input(event):
	if Input.is_action_just_pressed("Pause"):
		$CanvasLayer/Pause.popup_centered()

func _ready():
	if cardHandler.deck == []: cardHandler.init_starter()
	exit.connect("leaving_level", self, "reload_level")
	$CanvasLayer/FadeAnimator.play("Fade")

func reload_level():
	get_tree().reload_current_scene()
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
