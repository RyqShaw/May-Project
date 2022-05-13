extends Node2D

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

onready var CentralCardOval = get_viewport().size * Vector2(0.5, 1.1)
onready var hor_radius = get_viewport().size.x * 0.25
onready var vert_radius = get_viewport().size.y * 0.3
var angle = 0
var card_spread = 0.2
var num_card_hand = 0
var cnum = 0
var OvalAngleVector = Vector2()

enum {
	InHand
	InPlay
	InMouse
	FocusInHand
	MoveDrawnCardToHand
	ReOrganizeHand
}

#var xcoord = radius1 * cos angle
#var ycoord = radius2 * sin angle
func _input(event):
	if Input.is_action_just_pressed("LeftClick"): deal_card()
	
func deal_card():
	if cardHandler.deck.size() != 0:
		angle = PI/2 - card_spread*(float(num_card_hand)/2-num_card_hand)
		var card = cardHandler.deck.pop_front()
		OvalAngleVector = Vector2(hor_radius * cos(angle), - vert_radius * sin(angle))
		card.startpos = $Deck.position 
		card.targetpos = CentralCardOval + OvalAngleVector - (card.rect_size/2)
		card.cardpos = card.targetpos
		card.startrot = 0
		card.targetrot = (90 - rad2deg(angle))/6
		card.state = MoveDrawnCardToHand
		card.cnum = num_card_hand
		cnum = 0
		for Card in $Cards.get_children():
			angle = PI/2 - card_spread*(float(num_card_hand)/2-cnum)
			OvalAngleVector = Vector2(hor_radius * cos(angle), - vert_radius * sin(angle))
			Card.targetpos = CentralCardOval + OvalAngleVector - (Card.rect_size/2)
			Card.cardpos = Card.targetpos
			Card.startrot = Card.rect_rotation
			Card.targetrot = (90 - rad2deg(angle))/6
			if Card.state == InHand: 
				Card.state = ReOrganizeHand
				Card.startpos = Card.rect_position
			elif Card.state == MoveDrawnCardToHand:
				Card.startpos = Card.targetpos - ((Card.targetpos - Card.rect_position)/(1-Card.t))
			Card.cnum = cnum
			cnum+=1
		angle += 0.3
		num_card_hand += 1
		$Cards.add_child(card)
