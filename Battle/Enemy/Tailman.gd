extends "res://Battle/Enemy/EnemyBattle.gd"

var attacks = [
{"name": "whip", "weight": 20, "accumulated": 20}, 
{"name": "kick", "weight": 50, "accumulated": 70}, 
{"name": "shield", "weight": 30, "accumulated": 100}
]

var total = 0.0
var dmgBoost = 0

func _ready():
	$AnimatedSprite/HitAnimation.play("RESET")

func attack() -> void:
	resetProbabilities()
	setFlatDamageReduction(0)
	setMovePoints(2)
	yield(get_tree().create_timer(0.4), "timeout")
	boost()
	for each in movePoints:
		init_probabilities()
		var attack = get_attack()
		if attack.name == "whip":
			whip()
		elif attack.name == "kick":
			kick()
		else:
			shield()
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
		else:
			attack.weight = 30

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

func whip():
	pass

func kick():
	var damage = 2 + dmgBoost
	deal_damage(damage)

func shield():
	setFlatDamageReduction(4)

func boost():
	dmgBoost += 1
	$Boost.text = "+" + str(dmgBoost)

func _on_Enemy_health_lowered():
	$AnimatedSprite/HitAnimation.play("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	$AnimatedSprite/HitAnimation.stop()
	$AnimatedSprite/HitAnimation.play("RESET")
