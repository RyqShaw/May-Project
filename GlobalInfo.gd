extends Node

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")
const playerStats = preload("res://Battle/Player/PlayerStats.tres")

signal deck_changed

var rooms = 1
var deckSize = 10 setget set_deck_size 


func set_deck_size(value):
	deckSize = cardHandler.deck.size()
	emit_signal("deck_changed")

func reset_info():
	rooms = 1
	deckSize = 10
	cardHandler.deck = []
	playerStats.confidence = playerStats.max_confidence
	playerStats.max_moves = 3
	playerStats.moves = playerStats.max_moves
	playerStats.default_resistance = 0
	playerStats.resistance = playerStats.default_resistance
	playerStats.default_damage_mod = 1
	playerStats.damage_mod = playerStats.default_damage_mod
	playerStats.damageUp = false
	playerStats.shieldUp = false
	playerStats.enemyWeakened = false
	playerStats.enemyDmgDown = false
	playerStats.damageDouble = 1

func toggle_fullScreen(value):
	OS.window_fullscreen = value
	Save.game_data.fullscreen = value
	Save.save_data()

func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)
	Save.game_data.Master = vol
	Save.save_data()
func update_music_vol(vol):
	AudioServer.set_bus_volume_db(1, vol)
	Save.game_data.Music = vol
	Save.save_data()
func update_sfx_vol(vol):
	AudioServer.set_bus_volume_db(2, vol)
	Save.game_data.Sfx = vol
	Save.save_data()
