extends Node2D

const player = preload("res://Battle/Player/PlayerStats.tres")
const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

export(int) var max_confidence = 30
var confidence = max_confidence setget set_confidence

export(int) var damage = 5

onready var confBar = $EnemyConfBar/TextureProgress
onready var animationPlayer = $AnimationPlayer

signal on_death

func _ready():
	confBar.max_value = max_confidence
	battleUnits.Enemy = self

func _exit_tree():
	battleUnits.Enemy = null

func set_confidence(new_confidence):
	confidence = new_confidence
	confBar.value = new_confidence

func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer, "animation_finished")
	turnManager.turn = turnManager.PLAYER_TURN

func deal_damage():
	if player.resistance > damage: player.resistance = damage
	var damage_dealt = damage - player.resistance
	player.confidence -= damage_dealt
	
func take_damage(amount):
	self.confidence -= amount
	if is_dead():
		emit_signal("on_death")
		yield(get_tree().create_timer(0.4), "timeout")
		queue_free()
#	else:
#		animationPlayer.play("Shake")
		
func is_dead():
	return confidence <= 0
