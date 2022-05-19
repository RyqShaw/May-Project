extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

onready var playerSpace = $PlayerSpace
onready var camera = $Camera2D

signal gameOver

func _ready():
	SoundManager.play_music_at_volume(load("res://Music/BattleSongV1.wav"), -10.0)
	$AnimationPlayer.play("Scroll")
	randomize()
	$UI.hide()
	cardHandler.deck.shuffle()
	var player = battleUnits.Player
	
	battleUnits.Battle = self
	turnManager.connect("player_turn_started",self,"_player_turn_started")
	turnManager.connect("enemy_turn_started",self,"_enemy_turn_started")
	
	player.connect("moves_changed", self, "update_move_points")
	player.connect("max_moves_changed", self, "update_move_points")
	player.connect("no_confidence", self, "on_Player_died")
	
	cardHandler.deck.shuffle()
#	create_hand()
	
	#update_deck_label()
	update_move_points()
	turnManager.turn = turnManager.PLAYER_TURN
	camera.current = true
	$FadeAnimator.play("Fade")
	
func _player_turn_started():
	while $PlayerSpace/Cards.get_child_count() < 5: deal_card() #Change if we need to
	#update_deck_label()
	var player = battleUnits.Player
	player.resistance = player.default_resistance
	player.damage_mod = player.default_damage_mod
	if player.confidence == 0:
		on_Player_died()
	$UI.show()
	player.moves = player.max_moves

func _enemy_turn_started():
	$UI.hide()
	var enemy = battleUnits.Enemy
	if enemy != null:
		enemy.attack()

func create_hand():
	for i in 4:
		deal_card()
		yield(get_tree().create_timer(0.2), "timeout")
	#update_deck_label()

func deal_card():
	if cardHandler.deck.size() == 0:
		reshuffleDeck()
	playerSpace.deal_card()

func reshuffleDeck():
	cardHandler.discardPile.shuffle()
	cardHandler.append_discard()
	cardHandler.discardPile = []

func on_Player_died():
	$Player.queue_free()
	emit_signal("gameOver")
	# quit is temp line
	get_tree().quit()
	

func _on_Confirm_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	#update_deck_label()
	turnManager.turn = turnManager.ENEMY_TURN
	
func update_deck_label():
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n" + str(cardHandler.deck.size())

func update_move_points():
	$UI/MovePoints/Label.text = str(battleUnits.Player.moves) +'/'+str(battleUnits.Player.max_moves)

func _on_Enemy_on_death():
	SoundManager.stop_music()
	SoundManager.play_sound(load("res://SoundAffects/YouWin.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	$Camera2D.current = false
	$BG.visible = false
	var cardPicker = load("res://GUI/CardPicker.tscn").instance()
	get_tree().get_root().get_node("BaseLevel/CanvasLayer").add_child(cardPicker)
	get_tree().get_root().get_node("BaseLevel/Player/Camera2D").current = true
	yield(cardPicker, "card_chosen")
	#get_tree().get_root().get_node("BaseLevel/CanvasLayer/FadeAnimator").play()
	get_tree().paused = false
	#yield(get_tree().get_root().get_node("BaseLevel/CanvasLayer/FadeAnimator"), "animation_finished")
	#yield(get_tree().create_timer(0.1), "timeout")
	for card in battleUnits.playerSpace.get_node("Cards").get_children():
		cardHandler.discardPile.append(card.card_name)
	reshuffleDeck()
	queue_free()
