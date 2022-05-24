extends Control

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")
const cardDB = preload("res://CardDataBase.tres")

var card1
var card2
var card3

var crarity1 = 0
var crarity2 = 0
var crarity3 = 0

signal card_chosen

func _ready():
	get_tree().paused = true
	randomize()
	#once there is rare and epic cards, implement randomization between which rarity is chosen
	if randf() < 0.2:
		card1 = randi() % cardDB.rare_cards.size()
		crarity1 = 1
	else:
		card1 = randi() % cardDB.common_cards.size()
	if randf() < 0.2:
		card2 = randi() % cardDB.rare_cards.size()
		crarity2 = 1
	else:
		card2 = randi() % cardDB.common_cards.size()
	if randf() < 0.2:
		card3 = randi() % cardDB.rare_cards.size()
		crarity3 = 1
	else:
		card3 = randi() % cardDB.common_cards.size()

	pick_card(card1, $Panel/CardChoice1, crarity1)
	pick_card(card2, $Panel/CardChoice2, crarity2)
	pick_card(card3, $Panel/CardChoice3, crarity3)

func pick_card(card, panel, rarity):
	if rarity == 0:
		panel.get_node("Name").text = cardDB.common_cards[card]
		panel.get_node("Cost").text = str(cardDB.common_cost[card])
		panel.get_node("Info").text = cardDB.common_info[card]
	elif rarity == 1:
		panel.get_node("Name").text = cardDB.rare_cards[card]
		panel.get_node("Cost").text = str(cardDB.rare_cost[card])
		panel.get_node("Info").text = cardDB.rare_info[card]
	panel.texture = cardHandler.get_card_texture(card, rarity)


enum {
	NO_CARD,
	CARD1,
	CARD2,
	CARD3
}

var selected = NO_CARD

func _input(event):
	if event.is_action_pressed("LeftClick"):
		match selected:
			CARD1:
				cardHandler.discardPile.append(cardDB.common_cards[card1])
				cardHandler.append_discard()
				cardHandler.discardPile = []
				emit_signal("card_chosen")
				GlobalInfo.set_deck_size(0)
				get_tree().paused = false
				queue_free()
			CARD2:
				cardHandler.discardPile.append(cardDB.common_cards[card2])
				cardHandler.append_discard()
				cardHandler.discardPile = []
				emit_signal("card_chosen")
				GlobalInfo.set_deck_size(0)
				get_tree().paused = false
				queue_free()
			CARD3:
				cardHandler.discardPile.append(cardDB.common_cards[card3])
				cardHandler.append_discard()
				cardHandler.discardPile = []
				emit_signal("card_chosen")
				GlobalInfo.set_deck_size(0)
				get_tree().paused = false
				queue_free()
				

func _on_CardChoice1_mouse_entered():
	selected = CARD1

func _on_CardChoice2_mouse_entered():
	selected = CARD2

func _on_CardChoice3_mouse_entered():
	selected = CARD3
	
func _on_CardChoice1_mouse_exited():
	selected = NO_CARD

func _on_CardChoice2_mouse_exited():
	selected = NO_CARD

func _on_CardChoice3_mouse_exited():
	selected = NO_CARD

func _on_Leave_pressed():
	get_tree().paused = false
	queue_free()
