extends Control

const cardHandler = preload("res://Battle/Cards/CardHandler.tres")
const cardDB = preload("res://CardDataBase.tres")

func _ready():
	randomize()
	var card1 = cardDB.common_cards[randi() % cardDB.common_cards.size()]
	var card2 = cardDB.common_cards[randi() % cardDB.common_cards.size()]
	var card3 = cardDB.common_cards[randi() % cardDB.common_cards.size()]
	if card1 == "Twirlnado":
		$Panel/CardChoice1.texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
	elif card1 == "Pirou":
		$Panel/CardChoice1.texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
	elif card1 == "Caffinate":
		$Panel/CardChoice1.texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
	elif card1 == "The Whip":
		$Panel/CardChoice1.texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
