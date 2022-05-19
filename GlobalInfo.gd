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

func toggle_fullScreen(value):
	OS.window_fullscreen = value
	Save.game_data.fullscreen = value
	Save.save_data()

func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)
	Save.game_data.Master = vol
	Save.save_data()
	print(Save.game_data.Master)
func update_music_vol(vol):
	AudioServer.set_bus_volume_db(1, vol)
	Save.game_data.Music = vol
	Save.save_data()
	print(Save.game_data.Music)
func update_sfx_vol(vol):
	AudioServer.set_bus_volume_db(2, vol)
	Save.game_data.Sfx = vol
	Save.save_data()
	print(Save.game_data.Sfx)
