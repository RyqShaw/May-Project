extends Button

const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

export var moveValue = 1

enum {
	COMMON,
	RARE,
	EPIC
}
export var rarity = COMMON

func _on_CardButton_pressed():
	if get_parent().name == "Cards":
		get_tree().get_root().get_node("Battle").add_selected(self)
	elif get_parent().name == "SelectedCards":
		get_tree().get_root().get_node("Battle").add_hand(self)
		
func action():
	pass
