extends Popup

signal closed

func _on_Leave_Options_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	visible = false
	emit_signal("closed")
