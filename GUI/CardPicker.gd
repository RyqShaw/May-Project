extends Control

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")
const cardDB = preload("res://CardDataBase.tres")

var card1
var card2
var card3

signal card_chosen

func _ready():
	randomize()
	#once there is rare and epic cards, implement randomization between which rarity is chosen
	card1 = cardDB.common_cards[randi() % (cardDB.common_cards.size()-1)]
	card2 = cardDB.common_cards[randi() % (cardDB.common_cards.size()-1)]
	card3 = cardDB.common_cards[randi() % (cardDB.common_cards.size()-1)]
	pick_card(card1, $Panel/CardChoice1)
	pick_card(card2, $Panel/CardChoice2)
	pick_card(card3, $Panel/CardChoice3)
	print(card1)
	print(card2)
	print(card3+"\n")

func pick_card(card, panel):
	if card == "Twirlnado":
		panel.texture = load("res://Battle/ArtAssets/SharyqTwirlNado.png")
	elif card == "Pirouette":
		panel.texture = load("res://Battle/ArtAssets/pirou.png")
	elif card == "Caffinate":
		panel.texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
	elif card == "The Whip":
		panel.texture = load("res://Battle/ArtAssets/TheWhip.png")
	elif card == "Stretches":
		panel.texture = load("res://Battle/ArtAssets/CardBorder.png")

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
				cardHandler.discardPile.append(card1)
				cardHandler.append_discard()
				cardHandler.discardPile = []
				print(cardHandler.deck)
				emit_signal("card_chosen")
				queue_free()
			CARD2:
				cardHandler.discardPile.append(card2)
				cardHandler.append_discard()
				cardHandler.discardPile = []
				print(cardHandler.deck)
				emit_signal("card_chosen")
				queue_free()
			CARD3:
				cardHandler.discardPile.append(card3)
				cardHandler.append_discard()
				cardHandler.discardPile = []
				print(cardHandler.deck)
				emit_signal("card_chosen")
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
