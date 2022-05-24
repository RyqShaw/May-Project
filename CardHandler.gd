extends Resource
class_name CardHandler

const cardDB = preload("res://CardDataBase.tres")

export(Array, PackedScene) var deck = []
export(Array, PackedScene) var discardPile = []

func init_starter():
	var cards = []
	for i in 10:
		if randf() < 0.2:
			cards.append(cardDB.rare_cards[randi() % cardDB.rare_cards.size()])
		else:
			cards.append(cardDB.common_cards[randi() % cardDB.common_cards.size()])
	cards.shuffle()
	discardPile = cards
	append_discard()
	discardPile = []

func get_card_texture(card, rarity) -> Texture:
	var texture
	#Common
	if rarity == 0:
		if cardDB.common_cards[card] == "Twirlnado":
			texture = load("res://Battle/ArtAssets/Twirlnado.png")
		elif cardDB.common_cards[card] == "Pirouette":
			texture= load("res://Battle/ArtAssets/pirou.png")
		elif cardDB.common_cards[card] == "The Whip":
			texture = load("res://Battle/ArtAssets/TheWhip.png")
		elif cardDB.common_cards[card] == "Stretches":
			texture = load("res://Battle/ArtAssets/stretches.png")
		elif cardDB.common_cards[card] == "Water":
			texture = load("res://Battle/ArtAssets/Water.png")
		elif cardDB.common_cards[card] == "Dab":
			texture = load("res://Battle/ArtAssets/dab.png")

	#Rare
	elif rarity == 1:
		if cardDB.rare_cards[card] == "Caffinate":
			texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
		elif cardDB.rare_cards[card] == "Breakdance":
			texture = load("res://Battle/ArtAssets/breakdance.png")
		elif cardDB.rare_cards[card] == "M Water":
			texture = load("res://Battle/ArtAssets/mineralWater.png")
	return texture

func append_discard():
	for each in discardPile:
		#Common
		if each == "Twirlnado":
			deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
		elif each == "Pirouette":
			deck.append(preload("res://Battle/Cards/Pirouette.tscn").instance())
		elif each == "Choreography":
			deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
		elif each == "The Whip":
			deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
		elif each == "Stretches":
			deck.append(preload("res://Battle/Cards/Stretches.tscn").instance())
		elif each == "Water":
			deck.append(preload("res://Battle/Cards/Water.tscn").instance())
		elif each == "Dab":
			deck.append(preload("res://Battle/Cards/Dab.tscn").instance())
		
		#Rare
		elif each == "Caffinate":
			deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
		elif each == "Breakdance":
			deck.append(preload("res://Battle/Cards/Breakdance.tscn").instance())
		elif each == "M Water":
			deck.append(preload("res://Battle/Cards/MineralWater.tscn").instance())
