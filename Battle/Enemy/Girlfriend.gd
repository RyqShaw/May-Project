extends "res://Battle/Enemy/EnemyBattle.gd"

var attacks = [
{"name": "whip", "weight": 20, "accumulated": 20}, 
{"name": "kick", "weight": 50, "accumulated": 70}, 
{"name": "distract", "weight": 5, "accumulated": 75},
{"name": "hydrate", "weight": 25, "accumulated": 100},
]

enum {
	A,
	B,
	C
}

var moveSet = A
var total = 0.0
var dmgBoost = 0

func _ready():
	dmgBoost = 0
	$AnimatedSprite/HitAnimation.play("RESET")

func attack() -> void:
	resetProbabilities()
	setFlatDamageReduction(0)
	setMovePoints(2)
	yield(get_tree().create_timer(0.4), "timeout")
	
	match moveSet:
		A:
			boost()
			moveSet = B
		B:
			shield()
			moveSet = C
		C:
			slowDown()
			moveSet = A
	
	for each in movePoints:
		init_probabilities()
		var attack = get_attack()
		if attack.name == "whip":
			whip()
		elif attack.name == "kick":
			kick()
		elif attack.name == "distract":
			distract()
		else:
			hydrate()
	
	#	animationPlayer.play("Attack")
		SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
	#	yield(animationPlayer, "animation_finished")
	turnManager.turn = turnManager.PLAYER_TURN

func resetProbabilities() -> void:
	for attack in attacks:
		if attack.name == "whip":
			attack.weight = 20
		elif attack.name == "kick":
			attack.weight = 50
		elif attack.name == "distract":
			attack.weight = 5
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

func boost():
	dmgBoost += 2
	$Boost.text = "+" + str(dmgBoost)

func shield():
	setFlatDamageReduction(10)

func slowDown():
	#give player junk card
	print("junk card")
	pass

func whip():
	deal_damage(6)
	setDamageReduction(0.8)

func kick():
	var damage = 3 + dmgBoost
	deal_damage(damage)

func distract():
	#decrease MP
	print("MP down")
	pass

func hydrate():
	self.confidence += 2
	if confidence > max_confidence:
		set_confidence(max_confidence)

func _on_Enemy_health_lowered():
	$AnimatedSprite/HitAnimation.play("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	$AnimatedSprite/HitAnimation.stop()
	$AnimatedSprite/HitAnimation.play("RESET")
