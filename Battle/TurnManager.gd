extends Resource
class_name TurnManager

enum {
	PLAYER_TURN,
	ENEMY_TURN,
}

var turn setget set_turn

signal player_turn_started
signal enemy_turn_started

func set_turn(new_turn):
	turn = new_turn
	match turn:
		PLAYER_TURN: emit_signal("ally_turn_started")
		ENEMY_TURN: emit_signal("enemy_turn_started")
