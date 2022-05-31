extends "res://Battle/Enemy/EnemyBattle.gd"

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")
const distraction = preload("res://Battle/SpecialNodes/DistractCounter.tscn")
const shielder = preload("res://Battle/SpecialNodes/ShieldCounterGF.tscn")
const whipr = preload("res://Battle/SpecialNodes/BounceCounter.tscn")
const boostIndicator = preload("res://Battle/Player/WaltzBuff.tscn")

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
var dmgBoostGF = 0
var firstBoost = false

func _ready():
	dmgBoostGF = 0
	firstBoost = false
	#$AnimatedSprite/HitAnimation.play("RESET")

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
	dmgBoostGF += 2
	if not firstBoost:
		var indicator = boostIndicator.instance()
		indicator.get_node("Label").text = "+" + str(dmgBoostGF)
		battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
		firstBoost = true
	else:
		battleUnits.Battle.get_node("EnemyBuffs/WaltzBuff/Label").text = "+" + str(dmgBoostGF)

func shield():
	setFlatDamageReduction(10)
	var battle = battleUnits.Battle
	var c = shielder.instance()
	battle.get_node("PlayerCounters").add_child(c)

func slowDown():
	cardHandler.deck.append(preload("res://Battle/Cards/Stumble.tscn").instance())

func whip():
	deal_damage(6)
	setDamageReduction(0.8)
	var battle = battleUnits.Battle
	var c = whipr.instance()
	battle.get_node("PlayerCounters").add_child(c)

func kick():
	var damage = 3 + dmgBoostGF
	deal_damage(damage)

func distract():
	var battle = battleUnits.Battle
	var c = distraction.instance()
	battle.get_node("PlayerCounters").add_child(c)

func hydrate():
	self.confidence += 2
	if confidence > max_confidence:
		set_confidence(max_confidence)

func _on_Enemy_health_lowered():
	pass
#	$AnimatedSprite/HitAnimation.play("Hit")
#	yield(get_tree().create_timer(0.4), "timeout")
#	$AnimatedSprite/HitAnimation.stop()
#	$AnimatedSprite/HitAnimation.play("RESET")
