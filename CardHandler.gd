extends Resource
class_name CardHandler

export(Array, PackedScene) var deck = []
export(Array, PackedScene) var discardPile = []

func init_starter():
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
	deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
	deck.append(preload("res://Battle/Cards/Pirou.tscn").instance())
	deck.append(preload("res://Battle/Cards/Pirou.tscn").instance())
	deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
	deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
	deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())

func append_discard():
	for each in discardPile:
		if each == "Twirlnado":
			deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
		elif each == "Pirou":
			deck.append(preload("res://Battle/Cards/Pirou.tscn").instance())
		elif each == "Caffinate":
			deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
		elif each == "The Whip":
			deck.append(preload("res://Battle/Cards/The Whip.tscn").instance())
