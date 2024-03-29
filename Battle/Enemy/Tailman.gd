extends "res://Battle/Enemy/EnemyBattle.gd"

const shielder = preload("res://Battle/SpecialNodes/ShieldCounter.tscn")
const boostIndicator = preload("res://Battle/Player/WaltzBuff.tscn")

var attacks = [
{"name": "whip", "weight": 20, "accumulated": 20}, 
{"name": "kick", "weight": 50, "accumulated": 70}, 
{"name": "shield", "weight": 30, "accumulated": 100}
]

var total = 0.0
var dmgBoostTM = 0
var firstBoost = false

func _ready():
	dmgBoostTM = 0
	firstBoost = false
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
	var damage = 2 + dmgBoostTM
	deal_damage(damage)

func shield():
	setFlatDamageReduction(4)
	var battle = battleUnits.Battle
	var c = shielder.instance()
	battle.get_node("PlayerCounters").add_child(c)

func boost():
	if randf() < 0.9:
		dmgBoostTM += 1
		if not firstBoost:
			var indicator = boostIndicator.instance()
			indicator.get_node("Label").text = "+" + str(dmgBoostTM)
			battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
			firstBoost = true
		else:
			battleUnits.Battle.get_node("EnemyBuffs/WaltzBuff/Label").text = "+" + str(dmgBoostTM)

func _on_Enemy_health_lowered():
	$AnimatedSprite/HitAnimation.play("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	$AnimatedSprite/HitAnimation.stop()
	$AnimatedSprite/HitAnimation.play("RESET")
