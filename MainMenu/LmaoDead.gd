extends Control

func _ready():
	$FadeAnimator.play("Fade")
	GlobalInfo.reset_info()

func _on_Main_Menu_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")


func _on_Try_Again_pressed():
	Save.game_data.first_time = false
	Save.save_data()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")

func _on_Quit_pressed():
	Save.game_data.first_time = false
	Save.save_data()
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().quit()
