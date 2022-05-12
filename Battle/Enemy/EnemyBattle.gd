extends Node2D

const player = preload("res://Battle/Player/PlayerStats.tres")
const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

export(int) var max_confidence = 30
var confidence = max_confidence setget set_confidence

export(int) var damage = 5


const max_bar = 56
var bar = max_bar

onready var confidenceLabel = $confidenceLabel
onready var confidenceBar = $EnemyConfBar/Filling
onready var animationPlayer = $AnimationPlayer

signal on_death

func _ready():
	confidenceLabel.text = str(confidence) + " confidence"
	battleUnits.Enemy = self

func _exit_tree():
	battleUnits.Enemy = null

func set_confidence(new_confidence):
	confidence = new_confidence
	$confidenceLabel.text = str(confidence) + " confidence"
	bar = clamp(new_confidence, 0, max_bar)
	if confidenceBar != null:
		confidenceBar.rect_size.x = confidence * (max_bar/max_confidence)
	if confidence == max_confidence:
		confidenceBar.rect_size.x = max_bar

func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer, "animation_finished")
	turnManager.turn = turnManager.PLAYER_TURN

func deal_damage():
	player.confidence -= damage
	
func take_damage(amount):
	self.confidence -= amount
	if is_dead():
		emit_signal("on_death")
		queue_free()
#	else:
#		animationPlayer.play("Shake")
		
func is_dead():
	return confidence <= 0
