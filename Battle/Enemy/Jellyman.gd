extends "res://Battle/Enemy/EnemyBattle.gd"

var attacks = [
{"name": "slime", "weight": 15, "accumulated": 15}, 
{"name": "smack", "weight": 35, "accumulated": 50}, 
{"name": "concentrate", "weight": 25, "accumulated": 75},
{"name": "bounce", "weight": 25, "accumulated": 100}
]

var total = 0.0

func attack() -> void:
	resetProbabilities()
	setDamageReduction(1.0)
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
	#	animationPlayer.play("Attack")
		SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
	#	yield(animationPlayer, "animation_finished")
	turnManager.turn = turnManager.PLAYER_TURN

func resetProbabilities() -> void:
	for attack in attacks:
		if attack.name == "slime":
			attack.weight = 15
		elif attack.name == "concentrate":
			attack.weight = 25
		elif attack.name == "smack":
			attack.weight = 35
		else:
			attack.weight = 25

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
	#give player junk card
	for attack in attacks:
		if attack.name == "slime":
			attack.weight = 0

func smack():
	deal_damage(5)

func concentrate():
	self.confidence += 4
	if confidence > max_confidence:
		set_confidence(max_confidence)

func bounce():
	setDamageReduction(0.75)
	for attack in attacks:
		if attack.name == "bounce":
			attack.weight = 0
