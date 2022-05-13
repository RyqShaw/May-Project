extends Resource
class_name CardHandler

export(Array, PackedScene) var deck = []
export(Array, PackedScene) var discardPile = []

func init_starter():
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
	deck.append(preload("res://Battle/Cards/BaseCard/CardBase.tscn").instance())
