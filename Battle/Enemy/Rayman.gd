extends "res://Battle/Enemy/EnemyBattle.gd"

var attacks = [
{"name": "hyperBeam", "weight": 0, "accumulated": 0}, 
{"name": "beam", "weight": 50, "accumulated": 50}, 
{"name": "focus", "weight": 30, "accumulated": 80},
{"name": "confuse", "weight": 20, "accumulated": 100}
]

var total = 0.0
var focus = 0 setget setFocus

func attack() -> void:
	resetProbabilities()
	setEnemyDamageMod(1.0)
	setMovePoints(3)
	yield(get_tree().create_timer(0.4), "timeout")
	for each in movePoints:
		init_probabilities()
		var attack = get_attack()
		if attack.name == "hyperBeam":
			hyperBeam()
		elif attack.name == "beam":
			beam()
		elif attack.name == "focus":
			focus()
		else:
			confuse()
	#	animationPlayer.play("Attack")
		SoundManager.play_sound(load("res://SoundAffects/explosion.wav"))
	#	yield(animationPlayer, "animation_finished")
	turnManager.turn = turnManager.PLAYER_TURN

func resetProbabilities() -> void:
	for attack in attacks:
		if attack.name == "hyperBeam":
			attack.weight = 0
		elif attack.name == "beam":
			attack.weight = 50
		elif attack.name == "focus":
			attack.weight = 30
		else:
			attack.weight = 20

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

func hyperBeam():
	deal_damage(25)
	setFocus(0)
	resetProbabilities()
	setMovePoints(0)

func beam():
	deal_damage(7)

func focus():
	focus += 1
	if focus >= 4:
		for attack in attacks:
			if attack.name == "hyperBeam":
				attack.weight = 100
			else:
				attack.weight = 0

func confuse():
	setEnemyDamageMod(1.4)

func setFocus(newFocus):
	focus = newFocus

func _on_Enemy_health_lowered():
	$AnimatedSprite/HitAnimation.play("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	$AnimatedSprite/HitAnimation.stop()
	$AnimatedSprite/HitAnimation.play("RESET")