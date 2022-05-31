extends Node2D

onready var exit = $ExitDoor
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

func _input(event):
	if Input.is_action_just_pressed("Pause"):
		$CanvasLayer/Pause.popup_centered()

func _ready():
	if cardHandler.deck == []: cardHandler.init_starter()
	for card in cardHandler.deck:
		if card.name == "Stumble":
			cardHandler.deck.remove(cardHandler.deck.find(card))
			card.queue_free()
	exit.connect("leaving_level", self, "reload_level")
	$CanvasLayer/FadeAnimator.play("Fade")

func reload_level():
	cardHandler.deck == []
	get_tree().reload_current_scene()
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
