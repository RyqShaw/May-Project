extends Node2D

const player = preload("res://Battle/Player/PlayerStats.tres")
const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

export(int) var max_confidence = 30
export(int) var movePoints = 3 setget setMovePoints
var confidence = max_confidence setget set_confidence
var damageReduction = 1.0 setget setDamageReduction
var enemyDamageMod = 1.0 setget setEnemyDamageMod
var flatDamageReduction = 0 setget setFlatDamageReduction
var otherDamageMod = 1.0 setget setOtherDamageMod
var dmgBoost = 0 setget setDmgBoost

#export(int) var damage = 5

onready var confBar = $EnemyConfBar/TextureProgress
onready var animationPlayer = $AnimationPlayer

signal on_death
signal health_lowered

func _ready():
	set_confidence(max_confidence)
	confBar.max_value = max_confidence
	battleUnits.Enemy = self
	setDmgBoost(0)

func _exit_tree():
	battleUnits.Enemy = null

func set_confidence(new_confidence):
	confidence = new_confidence
	confBar.value = new_confidence
	$Health.text = str(confBar.value) +"/"+ str(max_confidence)

func deal_damage(dmg):
	var damage = int(dmg * enemyDamageMod * otherDamageMod)
	var damage_dealt = damage - player.resistance
	if damage_dealt > 0:
		player.confidence -= damage_dealt

func take_damage(amount):
	var dmg = int(amount * damageReduction)
	dmg = dmg + dmgBoost
	dmg = dmg - flatDamageReduction
	if dmg > 0:
		self.confidence -= dmg
		emit_signal("health_lowered")
		set_confidence(confidence)
	if is_dead():
		yield(get_tree().create_timer(0.4), "timeout")
		emit_signal("on_death")
		queue_free()

func setDamageReduction(value):
	damageReduction = value

func setEnemyDamageMod(newMod):
	enemyDamageMod = newMod

func setMovePoints(newPoints):
	movePoints = newPoints

func setFlatDamageReduction(value):
	flatDamageReduction = value

func setOtherDamageMod(value):
	otherDamageMod = value

func setDmgBoost(value):
	dmgBoost = value

func is_dead():
	return confidence <= 0
