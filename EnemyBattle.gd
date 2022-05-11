extends Node2D

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

export(int) var confidence = 25 setget set_confidence
export(int) var damage = 3

var target = null
onready var confidenceLabel = $confidenceLabel
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

func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer, "animation_finished")
	turnManager.turn = turnManager.ALLY_TURN

func deal_damage():
	battleUnits.PlayerStats.confidence -= damage
	
func take_damage(amount):
	self.confidence -= amount
	if is_dead():
		emit_signal("on_death")
		queue_free()
#	else:
#		animationPlayer.play("Shake")
		
func is_dead():
	return confidence <= 0
