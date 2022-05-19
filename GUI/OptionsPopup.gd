extends Popup

onready var masterVol = $OptionsPanel/VBoxContainer/GridContainer/MasterVol
onready var musicVol = $OptionsPanel/VBoxContainer/GridContainer/MusicVol
onready var sfxVol = $OptionsPanel/VBoxContainer/GridContainer/SoundVol
onready var back = $"OptionsPanel/Leave Options"
onready var fullScreen = $OptionsPanel/VBoxContainer/FullScreen

signal closed

func _ready():
	fullScreen.pressed = Save.game_data.fullscreen
	GlobalInfo.toggle_fullScreen(Save.game_data.fullscreen)
	masterVol.value = Save.game_data.Master
	musicVol.value = Save.game_data.Music
	sfxVol.value = Save.game_data.Sfx

func _on_MasterVol_value_changed(value):
	GlobalInfo.update_master_vol(value)


func _on_MusicVol_value_changed(value):
	GlobalInfo.update_music_vol(value)


func _on_SoundVol_value_changed(value):
	GlobalInfo.update_sfx_vol(value)


func _on_FullScreen_toggled(button_pressed):
	GlobalInfo.toggle_fullScreen(button_pressed)

func _on_Leave_Options_pressed():
	SoundManager.play_ui_sound(load("res://SoundAffects/blipSelect.wav"))
	visible = false
	emit_signal("closed")
