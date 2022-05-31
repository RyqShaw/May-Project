extends "res://Battle/Enemy/EnemyBattle.gd"

const confuser = preload("res://Battle/SpecialNodes/ConfuseCounter.tscn")
const focusIndicator = preload("res://Battle/Player/FocusIndicator.tscn")

var attacks = [
{"name": "hyperBeam", "weight": 0, "accumulated": 0}, 
{"name": "beam", "weight": 50, "accumulated": 50}, 
{"name": "focus", "weight": 30, "accumulated": 80},
{"name": "confuse", "weight": 20, "accumulated": 100}
]

var playedAttacks = []
var total = 0.0
var focus = 0 setget setFocus
var firstFocus = false

func _ready():
	firstFocus = false
	$AnimatedSprite/HitAnimation.play("RESET")

func attack() -> void:
	resetProbabilities()
	setEnemyDamageMod(1.0)
	setMovePoints(3)
	playedAttacks = []
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
		playedAttacks.append(attack.name)
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
	deal_damage(16)
	setFocus(0)
	battleUnits.Battle.get_node("EnemyBuffs/WaltzBuff/Label").text = "+" + str(focus)
	resetProbabilities()

func beam():
	deal_damage(6)
	if "beam" in playedAttacks:
		for attack in attacks:
			if attack.name == "beam":
				attack.weight = 0

func focus():
	focus += 1
	if focus >= 4:
		for attack in attacks:
			if attack.name == "hyperBeam":
				attack.weight = 100
			else:
				attack.weight = 0
	init_probabilities()
	
	if not firstFocus:
		var indicator = focusIndicator.instance()
		indicator.get_node("Label").text = "+" + str(focus)
		battleUnits.Battle.find_node("EnemyBuffs").add_child(indicator)
		firstFocus = true
	else:
		battleUnits.Battle.get_node("EnemyBuffs/FocusIndicator/Label").text = "+" + str(focus)
	
	if "focus" in playedAttacks:
		for attack in attacks:
			if attack.name == "focus":
				attack.weight = 0

func confuse():
	setEnemyDamageMod(1.2)
	var battle = battleUnits.Battle
	var c = confuser.instance()
	battle.get_node("PlayerCounters").add_child(c)
	if "confuse" in playedAttacks:
		for attack in attacks:
			if attack.name == "confuse":
				attack.weight = 0

func setFocus(newFocus):
	focus = newFocus

func _on_Enemy_health_lowered():
	$AnimatedSprite/HitAnimation.play("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	$AnimatedSprite/HitAnimation.stop()
	$AnimatedSprite/HitAnimation.play("RESET")
