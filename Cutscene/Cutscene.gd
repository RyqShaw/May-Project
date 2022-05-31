extends Control

func _ready():
	$AnimationPlayer.play("Scroll")
	$FadeAnimator.play("Fade")


func _on_Start_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	$FadeAnimator.play("FadeOut")
	yield($FadeAnimator, "animation_finished")
	SoundManager.play_music(load("res://Music/OverworldV3.wav"))
	get_tree().change_scene("res://Levels/BaseLevel.tscn")
