extends MarginContainer

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")

export var moveValue = 1

export(String) var card_name
export(int) var card_cost
export(String) var card_info

var startpos = Vector2(100,525)
var targetpos = Vector2()
var cardpos = Vector2()
var startrot = 0
var targetrot = 0
var t = 0
var drawTime = 0.4

onready var orig_scale = rect_scale

enum {
	InHand
	InPlay
	InMouse
	FocusInHand
	MoveDrawnCardToHand
	ReOrganizeHand
}
var state = InHand

var setup = true
var reorganize_neighbors = true
var startscale = Vector2()
var zoom_size = 1.5
var zoom_time = 0.2
var num_card_hand = 0
var cnum = 0
var move_neighbor_check = false

func _ready():
	$Border/Name.text = card_name
	$Border/Cost.text = str(card_cost)
	$Border/Info.text = card_info
	$CardBack.visible = true
	
var CARD_SELECT = true
var old_state = INF
var in_mouse_time = 0.1
func _input(event):
	match state:
		InMouse, FocusInHand:
			if event.is_action_pressed("LeftClick"):
				if CARD_SELECT:
					setup = true
					old_state = state
					state = InMouse
					CARD_SELECT = false
			if event.is_action_released("LeftClick"):
				if battleUnits.Player.moves - self.moveValue < 0:
					state = old_state
					CARD_SELECT = true
				elif CARD_SELECT == false:
					state = old_state
					if rect_position.y > 400:
						state = old_state
						CARD_SELECT = true
					elif rect_position.y <= 400:
						#Play card & Animation
						battleUnits.playerSpace.ReParentCard(self)

func _physics_process(delta):
	if turnManager.turn == turnManager.ENEMY_TURN:
		self.visible = false
	else:
		self.visible = true
	match state:
		InHand:
			pass
		InPlay:
			pass
		InMouse:
			if setup:
				set_up()
			if t <= 1:
				rect_position = startpos.linear_interpolate(get_global_mouse_position() - (rect_size/2), t)
				rect_rotation = startrot *(1-t) + 0*t
				rect_scale =  startscale *(1-t) + orig_scale*t
				t += delta/float(in_mouse_time)
			else:
				rect_rotation = 0
				rect_position = get_global_mouse_position() - (rect_size/2)
		FocusInHand:
			if setup:
				set_up()
			if t <= 1:
				rect_position = startpos.linear_interpolate(targetpos, t) 
				rect_rotation = startrot *(1-t) + 0*t
				rect_scale = startscale *(1-t) + orig_scale*zoom_size*t
				t += delta/float(zoom_time)
				if reorganize_neighbors:
					reorganize_neighbors = false
					num_card_hand = $'../../'.num_card_hand -1
				if cnum - 1 >= 0:
					Move_Neighbor_Card(cnum - 1,true,1.1) # true is left!
				if cnum - 2 >= 0:
					Move_Neighbor_Card(cnum - 2,true,0.75)
				if cnum + 1 <= num_card_hand:
					Move_Neighbor_Card(cnum + 1,false,1.1)
				if cnum + 2 <= num_card_hand:
					Move_Neighbor_Card(cnum + 2,false,0.75)
			else:
				rect_rotation = 0
				rect_position = targetpos
				rect_scale = orig_scale*zoom_size
		MoveDrawnCardToHand:
			if setup:
				set_up()
			if t <= 1:
				rect_position = startpos.linear_interpolate(targetpos, t)
				rect_rotation = startrot *(1-t) + targetrot*t
				rect_scale.x =  orig_scale.x * abs(2*t - 1)
				if $CardBack.visible:
					if t >= 0.5:
						$CardBack.visible = false
				t += delta/float(drawTime)
			else:
				rect_rotation = targetrot
				rect_position = targetpos
				$CardBack.visible = false
				state = InHand
				t = 0
		ReOrganizeHand:
			if setup:
				set_up()
			if t <= 1:
				if move_neighbor_check:
					move_neighbor_check = false
				rect_position = startpos.linear_interpolate(targetpos, t)
				rect_rotation = startrot *(1-t) + targetrot*t
				rect_scale = startscale *(1-t) + orig_scale*t
				t += delta/float(drawTime/4)
				if reorganize_neighbors == false:
					reorganize_neighbors = true
					if cnum - 1 >= 0:
						Reset_Neighbor(cnum-1)
					if cnum + 1 <= num_card_hand:
						Reset_Neighbor(cnum+1)
					if cnum - 2 >= 0:
						Reset_Neighbor(cnum-2)
					if cnum + 2 <= num_card_hand:
						Reset_Neighbor(cnum+2)
			else:
				rect_rotation = targetrot
				rect_position = targetpos
				rect_scale = orig_scale
				state = InHand
				t = 0

func Move_Neighbor_Card(num,left,spread):
	var neighbor = $'../'.get_child(num)
	if left:
		neighbor.targetpos = neighbor.targetpos + spread*Vector2(8,0) # edit number
	else:
		neighbor.targetpos = neighbor.targetpos - spread*Vector2(4,0) # edit number
	neighbor.setup = true
	neighbor.state = ReOrganizeHand
	neighbor.move_neighbor_check = true

func Reset_Neighbor(num):
	var neighbor = $'../'.get_child(num)
	if neighbor.move_neighbor_check == false:
		neighbor.targetpos = neighbor.cardpos
		neighbor.setup = true
		if neighbor.state != FocusInHand: 
			neighbor.state = ReOrganizeHand
			targetpos = cardpos
			setup = true

func set_up():
	startpos = rect_position
	startrot = rect_rotation
	startscale = rect_scale
	t = 0
	setup = false

func _on_mouse_entered():
	match state: 
		InHand, ReOrganizeHand:
			setup = true
			targetpos = cardpos
			targetpos.y = get_viewport().size.y - (rect_size.y)*zoom_size - rect_size.y/4
			state = FocusInHand

func _on_mouse_exited():
	match state: 
		FocusInHand:
			setup = true
			targetpos = cardpos
			state = ReOrganizeHand
			
func reset():
	setup = true
	$CardBack.visible = true
	state = MoveDrawnCardToHand

func action():
	pass
