extends Control

func _ready():
	$ViewportContainer/Viewport/BaseLevel/Camera2D.make_current()
	$ViewportContainer/Viewport/BaseLevel/Camera2D.zoom = Vector2(8,8)
