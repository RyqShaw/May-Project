extends Control

func _ready():
	$VBoxContainer/OptionsPanel.hide()
	$FadeAnimator.play("Fade")

func _on_Option_pressed():
	$VBoxContainer/OptionsPanel.show()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$Buttons.hide()

func _on_Leave_Options_pressed():
	$VBoxContainer/OptionsPanel.hide()
	$Buttons.show()

func _on_Start_pressed():
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
