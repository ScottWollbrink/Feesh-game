extends Control

@onready var settingsMenu = %SettingsMenu
var settingsOpen = false 

func _ready():
	AudioManager.musicPlayerMenu.play()
	#SettingsManager.load_config()



func _on_start_button_pressed():
	AudioManager.musicPlayerMenu.stop()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_settings_button_pressed():
	GlobalVars.prevScene = get_tree().get_current_scene()
	showSettingsMenu()
	
func _on_quit_button_pressed():
	get_tree().quit()

func showSettingsMenu():
	if settingsOpen:
		settingsMenu.hide()
	else:
		settingsMenu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	settingsOpen = !settingsOpen
