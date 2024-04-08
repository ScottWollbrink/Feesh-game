extends ColorRect

func _input(_event):
	if Input.is_action_pressed("restart") and %MainCharacter.isDead:
		get_tree().paused = false
		get_tree().reload_current_scene()
		print("Restarting game")
