extends Node

const turnManager = preload("res://Battle/TurnManager.tres")
const battleUnits = preload("res://Battle/BattleUnits.tres")
const cardHandler = preload("res://Battle/Cards/CardHandler.tres")

onready var playerSpace = $PlayerSpace
onready var camera = $Camera2D

export(Array, PackedScene) var enemies = []
export(AudioStream) var song

signal gameOver

var naenae = false
var glissadeDamage = 0
var last_card:String

func _input(event):
	if Input.is_action_just_pressed("Pause"):
		$Pause.popup_centered()

func _ready():
	SoundManager.play_music(song)
	$AnimationPlayer.play("Scroll")
	randomize()
	$UI.hide()
	cardHandler.deck.shuffle()
	var player = battleUnits.Player
	player.resistance = player.default_resistance
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
	create_new_enemy()

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	$EnemyPosition.add_child(enemy)
	if enemy != null:
		enemy.connect("on_death", self, "_on_Enemy_on_death")

func _player_turn_started():
	while $PlayerSpace/Cards.get_child_count() < 5: deal_card() #Change if we need to
	#update_deck_label()
	var player = battleUnits.Player
	player.resistance = player.default_resistance
	if player.enemyWeakened == false:
		player.damage_mod = player.default_damage_mod
	if player.confidence == 0:
		on_Player_died()
	$UI.show()
	player.moves = player.max_moves

func _enemy_turn_started():
	if not naenae:
		$UI.hide()
		var enemy = battleUnits.Enemy
		if enemy != null:
			enemy.attack()
	else:
		naenae = false
		turnManager.turn = turnManager.PLAYER_TURN

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
	$Player.hide()
	emit_signal("gameOver")
	$FadeAnimator.play("FadeOut")
	SoundManager.stop_music()
	yield($FadeAnimator, "animation_finished")
	get_tree().paused = false
	get_tree().change_scene("res://MainMenu/LmaoDead.tscn")
	queue_free()

func _on_Confirm_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	#update_deck_label()
	turnManager.turn = turnManager.ENEMY_TURN
	
func update_deck_label():
	$UI/Deck/RichTextLabel.text = "Number Of Cards Left in Deck: \n" + str(cardHandler.deck.size())

func update_move_points():
	$UI/MovePoints/Label.text = str(battleUnits.Player.moves) +'/'+str(battleUnits.Player.max_moves)

func _on_Enemy_on_death():
	for card in cardHandler.deck:
		if card.name == "Stumble":
			card.queue_free()
	var naenae = false
	var glissadeDamage = 0
	SoundManager.stop_music()
	SoundManager.play_sound(load("res://SoundAffects/YouWin.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	$Camera2D.current = false
	$BG.visible = false
	$Fade.visible = false
	$UI.visible = false
	$UI/Sprite.visible = false
	$UI/Confirm.visible = false
	$UI/MovePoints.visible = false
	$Player.visible = false
	$EnemyPosition.visible = false
	$PlayerSpace.visible = false
	$PlayerBuffs.visible = false
	$EnemyBuffs.visible = false
	
	get_tree().paused = false
	get_tree().change_scene("res://MainMenu/WinScreen.tscn")
	queue_free()
	

func append_last_card():
	cardHandler.append_last_card(last_card)
	deal_card()
