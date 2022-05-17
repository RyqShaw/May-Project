extends Area2D

var playerNear = false

func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			pass
		elif playerNear:
			playerNear = false
			$AnimationPlayer.play("Closing")
