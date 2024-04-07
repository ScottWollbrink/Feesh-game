extends Control

@onready var main = $"../../"

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(_event):
	if Input.is_action_just_pressed("ui_end"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		await get_tree().process_frame
		get_tree().paused = false
		
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = false


func _on_resume_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	main.showPauseMenu()
	get_tree().paused = false

func _on_quit_button_pressed():
	get_tree().quit()


