extends Node2D

var enemyList = [
	preload("res://Scenes/turtle.tscn"),
	preload("res://Scenes/jelly.tscn"),
	preload("res://Scenes/eel.tscn")
]

func spawnMob():
	var randomEnemy = randi_range(0, 2)
	var spawnedMob = enemyList[randomEnemy].instantiate()
	%PathFollow2D.progress_ratio = randf()
	spawnedMob.global_position = %PathFollow2D.global_position
	add_child(spawnedMob)
	
func _on_timer_timeout():
	spawnMob()
