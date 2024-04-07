extends Node2D

@onready var pauseMenu = %PauseMenu
var paused = false 

var enemyList = [
	preload("res://Scenes/turtle.tscn"),
	preload("res://Scenes/jelly.tscn"),
	preload("res://Scenes/eel.tscn")
]
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		showPauseMenu()
	
	$HUD.updateLevel(%MainCharacter._playerLevel)
func spawnMob():
	var randomEnemy = randi_range(0, 2)
	var spawnedMob = enemyList[randomEnemy].instantiate()
	%PathFollow2D.progress_ratio = randf()
	spawnedMob.global_position = %PathFollow2D.global_position
	add_child(spawnedMob)
	
func _on_timer_timeout():
	spawnMob()

func showPauseMenu():
	if paused:
		pauseMenu.hide()
		Engine.time_scale = 1
	else:
		pauseMenu.show()
		Engine.time_scale = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	paused = !paused
