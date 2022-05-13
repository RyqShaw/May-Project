extends Resource
class_name CardHandler

export(Array, PackedScene) var deck = []
export(Array, PackedScene) var discardPile = []
export(Array, PackedScene) var starterDeck = []

func init_starter():
	deck.append_array([load("res://Battle/Cards/TheWhip.tscn").instance(),
	load("res://Battle/Cards/Caffinate.tscn").instance(),
	load("res://Battle/Cards/Choreography.tscn").instance(),
	load("res://Battle/Cards/Pirovette.tscn").instance(),
	load("res://Battle/Cards/Strecthes.tscn").instance(),
	load("res://Battle/Cards/Twirlnado.tscn").instance()])
