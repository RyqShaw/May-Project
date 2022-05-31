extends Resource
class_name CardHandler

const cardDB = preload("res://CardDataBase.tres")

export(Array, PackedScene) var deck = []
export(Array, PackedScene) var discardPile = []
export(Array, PackedScene) var exhaustPile = []

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
		elif cardDB.common_cards[card] == "The Whip":
			texture = load("res://Battle/ArtAssets/TheWhip.png")
		elif cardDB.common_cards[card] == "Stretches":
			texture = load("res://Battle/ArtAssets/stretches.png")
		elif cardDB.common_cards[card] == "Water":
			texture = load("res://Battle/ArtAssets/Water.png")
		elif cardDB.common_cards[card] == "Dab":
			texture = load("res://Battle/ArtAssets/dab.png")
		elif cardDB.common_cards[card] == "Running Man":
			texture = load("res://Battle/ArtAssets/runninMan.png")
		elif cardDB.common_cards[card] == "Cha Cha":
			texture = load("res://Battle/ArtAssets/runninMan.png")
		elif cardDB.common_cards[card] == "Choreography":
			texture = load("res://Battle/ArtAssets/runninMan.png")
		elif cardDB.common_cards[card] == "Widen Stance":
			texture = load("res://Battle/ArtAssets/widen.png")

	#Rare
	elif rarity == 1:
		if cardDB.rare_cards[card] == "Caffeinate":
			texture = load("res://Battle/ArtAssets/caffeine_fix-3.png")
		elif cardDB.rare_cards[card] == "Breakdance":
			texture = load("res://Battle/ArtAssets/breakdance.png")
		elif cardDB.rare_cards[card] == "Mineral Water":
			texture = load("res://Battle/ArtAssets/mineralWater.png")
		elif cardDB.rare_cards[card] == "Drop It Down":
			texture = load("res://Battle/ArtAssets/dropit.png")
		elif cardDB.rare_cards[card] == "Waltz":
			texture = load("res://Battle/ArtAssets/waltz.png")
		elif cardDB.rare_cards[card] == "Glissade":
			texture = load("res://Battle/ArtAssets/pirou.png")
			
	elif rarity == 2:
		if cardDB.epic_cards[card] == "Fiji Water":
			texture = load("res://Battle/ArtAssets/FijiWater.png")
		if cardDB.epic_cards[card] == "Nae Nae":
			texture = load("res://Battle/ArtAssets/TheNaeNae.png")
	return texture

func append_discard():
	for each in discardPile:
		#Common
		if each == "Twirlnado":
			deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
		elif each == "The Whip":
			deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
		elif each == "Stretches":
			deck.append(preload("res://Battle/Cards/Stretches.tscn").instance())
		elif each == "Water":
			deck.append(preload("res://Battle/Cards/Water.tscn").instance())
		elif each == "Dab":
			deck.append(preload("res://Battle/Cards/Dab.tscn").instance())
		elif each == "Running Man":
			deck.append(preload("res://Battle/Cards/RunningMan.tscn").instance())
		elif each == "Cha Cha":
			deck.append(preload("res://Battle/Cards/ChaCha.tscn").instance())
		elif each == "Choreography":
			deck.append(preload("res://Battle/Cards/Choreography.tscn").instance())
		elif each == "Widen Stance":
			deck.append(preload("res://Battle/Cards/Widen Stance.tscn").instance())
		
		#Rare
		elif each == "Caffeinate":
			deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
		elif each == "Breakdance":
			deck.append(preload("res://Battle/Cards/Breakdance.tscn").instance())
		elif each == "Mineral Water":
			deck.append(preload("res://Battle/Cards/MineralWater.tscn").instance())
		elif each == "Drop It Down":
			deck.append(preload("res://Battle/Cards/DropItDown.tscn").instance())
		elif each == "Waltz":
			deck.append(preload("res://Battle/Cards/Waltz.tscn").instance())
		elif each == "Glissade":
			deck.append(preload("res://Battle/Cards/Glissade.tscn").instance())
		
		#epic
		elif each == "Fiji Water":
			deck.append(preload("res://Battle/Cards/FijiWater.tscn").instance())
		elif each == "Nae Nae":
			deck.append(preload("res://Battle/Cards/TheNaeNae.tscn").instance())

func append_exhaust():
	for each in exhaustPile:
		if each == "Waltz":
			deck.append(preload("res://Battle/Cards/Waltz.tscn").instance())
