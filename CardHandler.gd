extends Resource
class_name CardHandler

export(Array, PackedScene) var deck = []
export(Array, PackedScene) var discardPile = []

func init_starter():
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Twirlnado.tscn").instance())
	deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
	deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
	deck.append(preload("res://Battle/Cards/Caffinate.tscn").instance())
