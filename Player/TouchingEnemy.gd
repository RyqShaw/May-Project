extends Area2D

signal battleStart

func _on_TouchingEnemy_body_entered(body):
	var battle = load("res://Battle/Battle.tscn").instance()
	get_tree().get_root().add_child(battle)
	emit_signal("battleStart")
	$'../'.queue_free()
	get_tree().paused = true
