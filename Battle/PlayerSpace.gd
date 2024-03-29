extends Node2D

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

onready var CentralCardOval = get_viewport().size * Vector2(0.5, 1.022)
onready var hor_radius = get_viewport().size.x * 0.25
onready var vert_radius = get_viewport().size.y * 0.2
var angle = 0
var card_spread = 0.3
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
func _ready():
	battleUnits.playerSpace = self

onready var deckPos = $Deck.position 

func deal_card():
	angle = PI/2 - card_spread*(float(num_card_hand)/2-num_card_hand)
	var card = cardHandler.deck.pop_front()
	OvalAngleVector = Vector2(hor_radius * cos(angle), - vert_radius * sin(angle))
	card.rect_position = deckPos
	card.targetpos = CentralCardOval + OvalAngleVector - (card.rect_size/2)
	card.cardpos = card.targetpos
	card.startrot = 0
	card.targetrot = (90 - rad2deg(angle))/6
	card.state = MoveDrawnCardToHand
	card.cnum = num_card_hand # maybe right i forget because me me dumb dumb
	cnum = 0
	organize_hand()
	angle += 0.3
	num_card_hand += 1
	$Cards.add_child(card)

func ReParentCard(card):
	num_card_hand -= 1
	cnum = 0
	$Cards.remove_child(card)
	card.action()
	battleUnits.Player.moves -= card.moveValue
	if card.name != "Waltz":
		cardHandler.discardPile.append(card.card_name)
	elif card.name == "Waltz":
		cardHandler.exhaustPile.append(card.card_name)
	battleUnits.Battle.last_card = card.card_name
	card.queue_free()
	organize_hand()

func organize_hand():
	for Card in $Cards.get_children():
		angle = PI/2 - card_spread*(float(num_card_hand)/2-cnum)
		OvalAngleVector = Vector2(hor_radius * cos(angle), - vert_radius * sin(angle))
		Card.targetpos = CentralCardOval + OvalAngleVector - (Card.rect_size/2)
		Card.cardpos = Card.targetpos
		Card.startrot = Card.rect_rotation
		Card.targetrot = (90 - rad2deg(angle))/6
		if Card.state == InHand: 
			Card.setup = true
			Card.state = ReOrganizeHand
		elif Card.state == MoveDrawnCardToHand:
			Card.startpos = Card.targetpos - ((Card.targetpos - Card.rect_position)/(1-Card.t))
		Card.cnum = cnum
		cnum+=1
