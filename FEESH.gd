extends Node2D


func spawnMob():
	var newTurtle = preload("res://Scenes/turtle.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	newTurtle.global_position = %PathFollow2D.global_position
	add_child(newTurtle)

func _on_timer_timeout():
	spawnMob()
