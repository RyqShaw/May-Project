extends Node

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

signal deck_changed

var rooms = 1
var deckSize = 10 setget set_deck_size

func set_deck_size(value):
	deckSize = cardHandler.deck.size()
	emit_signal("deck_changed")

func reset_info():
	rooms = 1
	deckSize = 10
