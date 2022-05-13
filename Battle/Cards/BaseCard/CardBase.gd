extends MarginContainer

export(String) var card_name
export(int) var card_cost
export(String) var card_info

func _ready():
	$Border/Name.text = card_name
	$Border/Cost.text = str(card_cost)
	$Border/Info.text = card_info
