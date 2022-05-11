extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

onready var hand = get_tree().get_root().get_node("Battle/UI/Cards")
onready var selectedCards = get_tree().get_root().get_node("Battle/UI/SelectedCards")

func _ready():
	$UI.hide()
	var player = battleUnits.PlayerStats
	
	turnManager.connect("player_turn_started",self,"_player_turn_started")
	turnManager.connect("enemy_turn_started",self,"_enemy_turn_started")
	player.connect("no_confidence", self, "on_Player_died")
	
	#Init Deck for testing purposes
	cardHandler.deck.append(load("res://Battle/Cards/CardButton.tscn").instance())
	for i in 39:
		cardHandler.deck.append(load("res://Battle/Cards/AttackCardButton.tscn").instance())
	create_hand()
	
	update_deck_label()
	turnManager.turn = turnManager.PLAYER_TURN
	
func _player_turn_started():
	if hand.get_child_count() != 7: deal_card()
	update_deck_label()
	var player = battleUnits.PlayerStats
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
	for i in 7:
		deal_card()

func deal_card():
	var card = cardHandler.deck.pop_front()
	get_tree().get_root().get_node("Battle/UI/Cards").add_child(card)

func on_Player_died():
#	$Player.queue_free()
#	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
	
func add_hand(card):
	if hand.get_child_count() < 7:
		selectedCards.remove_child(card)
		hand.add_child(card)
		battleUnits.PlayerStats.moves += card.moveValue
	
func add_selected(card):
	if selectedCards.get_child_count() < battleUnits.PlayerStats.moves:
		hand.remove_child(card)
		selectedCards.add_child(card)
		battleUnits.PlayerStats.moves -= card.moveValue


func _on_Confirm_pressed():
	for i in selectedCards.get_children():
		i.action()
		selectedCards.remove_child(i)
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n\n" + str(cardHandler.deck.size())
	turnManager.turn = turnManager.ENEMY_TURN
	
func update_deck_label():
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n\n" + str(cardHandler.deck.size())
