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
	card1 = randi() % cardDB.common_cards.size()
	card2 = randi() % cardDB.common_cards.size()
	card3 = randi() % cardDB.common_cards.size()

	pick_card(card1, $Panel/CardChoice1)
	pick_card(card2, $Panel/CardChoice2)
	pick_card(card3, $Panel/CardChoice3)

func pick_card(card, panel):
	panel.get_node("Name").text = cardDB.common_cards[card]
	panel.get_node("Cost").text = str(cardDB.common_cost[card])
	panel.get_node("Info").text = cardDB.common_info[card]
	if cardDB.common_cards[card] == "Twirlnado":
		panel.texture = load("res://Battle/ArtAssets/Twirlnado.png")
	elif cardDB.common_cards[card] == "Pirouette":
		panel.texture = load("res://Battle/ArtAssets/pirou.png")
	elif cardDB.common_cards[card] == "Caffinate":
		panel.texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
	elif cardDB.common_cards[card] == "The Whip":
		panel.texture = load("res://Battle/ArtAssets/TheWhip.png")
	elif cardDB.common_cards[card] == "Stretches":
		panel.texture = load("res://Battle/ArtAssets/stretches.png")
	elif cardDB.common_cards[card] == "Water":
		panel.texture = load("res://Battle/ArtAssets/Water.png")


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
				queue_free()
			CARD2:
				cardHandler.discardPile.append(cardDB.common_cards[card2])
				cardHandler.append_discard()
				cardHandler.discardPile = []
				emit_signal("card_chosen")
				GlobalInfo.set_deck_size(0)
				queue_free()
			CARD3:
				cardHandler.discardPile.append(cardDB.common_cards[card3])
				cardHandler.append_discard()
				cardHandler.discardPile = []
				emit_signal("card_chosen")
				GlobalInfo.set_deck_size(0)
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
