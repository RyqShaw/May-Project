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
	print(cards)
	cards.shuffle()
	discardPile = cards
	append_discard()
	discardPile = []
	print(deck)
#	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
#	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
#	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
#	deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
#	deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
#	deck.append(preload("res://Battle/Cards/Pirouette.tscn").instance())
#	deck.append(preload("res://Battle/Cards/Pirouette.tscn").instance())
#	deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
#	deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
#	deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())

func append_discard():
	for each in discardPile:
		if each == "Twirlnado":
			deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
		elif each == "Pirouette":
			deck.append(preload("res://Battle/Cards/Pirouette.tscn").instance())
		elif each == "Caffinate":
			deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
		elif each == "The Whip":
			deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
		elif each == "Stretches":
			deck.append(preload("res://Battle/Cards/Stretches.tscn").instance())
		elif each == "Water":
			deck.append(preload("res://Battle/Cards/Stretches.tscn").instance())
