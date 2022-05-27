extends "res://Battle/Enemy/EnemyBattle.gd"

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

var attacks = [
{"name": "slime", "weight": 11, "accumulated": 11}, 
{"name": "smack", "weight": 45, "accumulated": 56}, 
{"name": "concentrate", "weight": 22, "accumulated": 78},
{"name": "bounce", "weight": 22, "accumulated": 100}
]

var playedAttacks = []
var total = 0.0

func _ready():
	$AnimatedSprite/HitAnimation.play("RESET")

func attack() -> void:
	resetProbabilities()
	setDamageReduction(1.0)
	playedAttacks = []
	yield(get_tree().create_timer(0.4), "timeout")
	for each in movePoints:
		init_probabilities()
		var attack = get_attack()
		if attack.name == "slime":
			slime()
		elif attack.name == "concentrate":
			concentrate()
		elif attack.name == "smack":
			smack()
		else:
			bounce()
		playedAttacks.append(attack.name)
	#	animationPlayer.play("Attack")
		SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
	#	yield(animationPlayer, "animation_finished")
	turnManager.turn = turnManager.PLAYER_TURN

func resetProbabilities() -> void:
	for attack in attacks:
		if attack.name == "slime":
			attack.weight = 11
		elif attack.name == "concentrate":
			attack.weight = 22
		elif attack.name == "smack":
			attack.weight = 45
		else:
			attack.weight = 22

func init_probabilities() -> void:
	total = 0.0
	for attack in attacks:
		total += attack.weight
		attack.accumulated = total

func get_attack() -> Dictionary:
	var roll: float = rand_range(0.0, total)
	for attack in attacks:
		if (attack.accumulated > roll):
			return attack
	return {}

func slime():
	cardHandler.deck.append(preload("res://Battle/Cards/Stumble.tscn").instance())
	for attack in attacks:
		if attack.name == "slime":
			attack.weight = 0

func smack():
	deal_damage(5)
	if "smack" in playedAttacks:
		for attack in attacks:
			if attack.name == "smack":
				attack.weight = 0

func concentrate():
	self.confidence += 3
	if confidence > max_confidence:
		set_confidence(max_confidence)
	if "concentrate" in playedAttacks:
		for attack in attacks:
			if attack.name == "concentrate":
				attack.weight = 0

func bounce():
	setDamageReduction(0.75)
	for attack in attacks:
		if attack.name == "bounce":
			attack.weight = 0

func _on_Enemy_health_lowered():
	$AnimatedSprite/HitAnimation.play("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	$AnimatedSprite/HitAnimation.stop()
	$AnimatedSprite/HitAnimation.play("RESET")
