extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

onready var playerSpace = $PlayerSpace

func _ready():
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
	
func _player_turn_started():
#	if $PlayerSpace/Cards.get_child_count() != 5: deal_card()
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

#func create_hand():
#	for i in 5:
#		deal_card()

#func deal_card():
#	playerSpace.deal_card()
#	if cardHandler.deck.size() == 0:
#		cardHandler.discardPile.shuffle()
#		cardHandler.deck.append_array(cardHandler.discardPile)
#		cardHandler.discardPile = []
#	var card = cardHandler.deck.pop_front()
#	get_tree().get_root().get_node("Battle/UI/Cards").add_child(card)

func on_Player_died():
#	$Player.queue_free()
#	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
	
#func add_hand(card):
#	if hand.get_child_count() < 5:
#		battleUnits.Player.moves += card.moveValue
#		selectedCards.remove_child(card)
#		hand.add_child(card)
#
#func add_selected(card):
#	if battleUnits.Player.moves - card.moveValue >= 0:
#		battleUnits.Player.moves -= card.moveValue
#		hand.remove_child(card)
#		selectedCards.add_child(card)

func _on_Confirm_pressed():
#	for i in selectedCards.get_children():
#		i.action()
#		cardHandler.discardPile.append(i)
#		selectedCards.remove_child(i)
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n\n" + str(cardHandler.deck.size())
	turnManager.turn = turnManager.ENEMY_TURN
	
func update_deck_label():
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n\n" + str(cardHandler.deck.size())
