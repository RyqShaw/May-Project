extends Popup

signal closed

func _ready():
	if OS.has_feature("web"): $Panel/HBoxContainer/Quit.queue_free()

func _on_Resume_pressed():
	get_tree().paused = false
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	visible = false
	emit_signal("closed")


func _on_Option_pressed():
	visible = false
	$OptionsPopup.popup(Rect2(20,48+72,1240,452))
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))


func _on_Quit_pressed():
	Save.game_data.first_time = false
	Save.save_data()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	if OS.has_feature("web"): get_tree().change_scene("res://MainMenu/MainMenu.tscn")
	else: 
		yield(get_tree().create_timer(0.2), "timeout")
		get_tree().quit()


func _on_OptionsPopup_closed():
	visible = true


func _on_Pause_about_to_show():
	get_tree().paused = true
