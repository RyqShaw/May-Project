extends Control

func _ready():
	$FadeAnimator.play("Fade")

func _on_Main_Menu_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")


func _on_Try_Again_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	get_tree().change_scene("res://Levels/BaseLevel.tscn")


func _on_Quit_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().quit()
