extends Control

func _ready():
	$FadeAnimator.play("Fade")
	$AnimationPlayer.play("Scroll")
	if Save.game_data.first_time == true:
		$"Tutorial Pointer".show()
	else:
		$"Tutorial Pointer".hide()

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
	SoundManager.play_music(load("res://Music/OverworldV1.wav"))
	get_tree().change_scene("res://Levels/BaseLevel.tscn")


func _on_Extras_pressed():
	$"Tutorial Pointer".hide()
	Save.game_data.first_time = false
	Save.save_data()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$ExtrasPopUp.popup(Rect2(20,68+72,1240,452))
	$Buttons.hide()


func _on_Quit_pressed():
	$"Tutorial Pointer".hide()
	Save.game_data.first_time = false
	Save.save_data()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().quit()


func _on_OptionsPopup_closed():
	$Buttons.show()
