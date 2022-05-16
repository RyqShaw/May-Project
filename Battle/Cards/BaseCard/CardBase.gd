extends MarginContainer

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

func _ready():
	$Border/Name.text = card_name
	$Border/Cost.text = str(card_cost)
	$Border/Info.text = card_info
	$CardBack.visible = true

func _physics_process(delta):
	match state:
		InHand:
			pass
		InPlay:
			pass
		InMouse:
			pass
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
				rect_rotation = targetrot
				rect_position = targetpos
				rect_scale = orig_scale*zoom_size
		MoveDrawnCardToHand:
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
				state = InHand
				t = 0
		ReOrganizeHand:
			if setup:
				set_up()
			if t <= 1:
				rect_position = startpos.linear_interpolate(targetpos, t)
				rect_rotation = startrot *(1-t) + targetrot*t
				rect_scale = startscale *(1-t) + orig_scale*t
				t += delta/float(drawTime/1.5)
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

func Reset_Neighbor(num):
	var neighbor = $'../'.get_child(num)
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
