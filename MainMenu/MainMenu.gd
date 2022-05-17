extends Control

func _ready():
	$VBoxContainer/OptionsPanel.hide()
	$FadeAnimator.play("Fade")
	$AnimationPlayer.play("Scroll")

func _on_Option_pressed():
	$VBoxContainer/OptionsPanel.show()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$Buttons.hide()

func _on_Leave_Options_pressed():
	$VBoxContainer/OptionsPanel.hide()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$Buttons.show()

func _on_Start_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
