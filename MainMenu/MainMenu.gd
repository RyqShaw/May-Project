extends Control

func _ready():
	$FadeAnimator.play("Fade")
	$AnimationPlayer.play("Scroll")

func _on_Option_pressed():
	$VBoxContainer/OptionsPopup.popup(Rect2(20,48+72,1240,452))
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$Buttons.hide()

#func _on_Leave_Options_pressed():
#	$VBoxContainer/OptionsPopup.popup()
#	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
#	$Buttons.show()

func _on_Start_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")


func _on_Extras_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))


func _on_Quit_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().quit()


func _on_OptionsPopup_closed():
	$Buttons.show()
