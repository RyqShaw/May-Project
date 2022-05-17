extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

onready var playerSpace = $PlayerSpace
onready var camera = $Camera2D

signal gameOver

func _ready():
	$AnimationPlayer.play("Scroll")
	randomize()
	$UI.hide()
	cardHandler.deck.shuffle()
	var player = battleUnits.Player
	
	battleUnits.Battle = self
	turnManager.connect("player_turn_started",self,"_player_turn_started")
	turnManager.connect("enemy_turn_started",self,"_enemy_turn_started")
	player.connect("no_confidence", self, "on_Player_died")
	
	#Init Deck for testing purposes
	if cardHandler.deck.empty() : cardHandler.init_starter()
	cardHandler.deck.shuffle()
#	create_hand()
	
	update_deck_label()
	turnManager.turn = turnManager.PLAYER_TURN
	camera.current = true
	$FadeAnimator.play("Fade")
	
func _player_turn_started():
	while $PlayerSpace/Cards.get_child_count() < 5: deal_card() #Change if we need to
	update_deck_label()
	var player = battleUnits.Player
	player.resistance = player.default_resistance
	player.damage_mod = player.default_damage_mod
	if player.confidence == 0:
		on_Player_died()
	$UI.show()
	player.moves = player.max_moves

func _enemy_turn_started():
	$UI.hide()
	var enemy = battleUnits.Enemy
	if enemy != null:
		enemy.attack()

func create_hand():
	for i in 4:
		deal_card()
		yield(get_tree().create_timer(0.2), "timeout")
	update_deck_label()

func deal_card():
	if cardHandler.deck.size() == 0:
		reshuffleDeck()
	playerSpace.deal_card()

func reshuffleDeck():
	cardHandler.discardPile.shuffle()
	for each in cardHandler.discardPile:
		if each == "Twirlnado":
			cardHandler.deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
		elif each == "Pirou":
			cardHandler.deck.append(preload("res://Battle/Cards/Pirou.tscn").instance())
		elif each == "Caffinate":
			cardHandler.deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
	cardHandler.discardPile = []

func on_Player_died():
	$Player.queue_free()
	emit_signal("gameOver")
	# quit is temp line
	get_tree().quit()
	

func _on_Confirm_pressed():
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n" + str(cardHandler.deck.size())
	turnManager.turn = turnManager.ENEMY_TURN
	
func update_deck_label():
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n" + str(cardHandler.deck.size())

func _on_Enemy_on_death():
	get_tree().paused = false
	get_tree().get_root().get_node("BaseLevel/FadeAnimator").play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().get_root().get_node("BaseLevel/Player/Camera2D").current = true
	for card in battleUnits.playerSpace.get_node("Cards").get_children():
		cardHandler.deck.append(card)
	queue_free()
