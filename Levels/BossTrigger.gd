extends Area2D

func _on_BossTrigger_body_entered(body):
	var battle = load("res://Battle/BossBattle.tscn").instance()
	get_tree().get_root().add_child(battle)
	emit_signal("battleStart")
	$'../'.queue_free()
	get_tree().paused = true


func _on_Area2D_body_entered(body):
	$Label.visible = true


func _on_Area2D_body_exited(body):
	$Label.visible = false
