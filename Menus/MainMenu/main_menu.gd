extends Control


func _ready():
	pass
	#SettingsManager.load_config()



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://Menus/SettingsMenu/settings_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()




