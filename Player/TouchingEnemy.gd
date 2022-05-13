extends Area2D

signal battleStart

func _on_TouchingEnemy_body_entered(body):
	emit_signal("battleStart")
	print("start")
