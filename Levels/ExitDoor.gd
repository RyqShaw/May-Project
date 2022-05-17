extends Area2D

signal leaving_level

func _on_ExitDoor_body_entered(body):
	emit_signal("leaving_level")

func _on_PlayerNear_body_entered(body):
	$AnimationPlayer.play("Opening")

func _on_PlayerNear_body_exited(body):
	$AnimationPlayer.play("Closing")
