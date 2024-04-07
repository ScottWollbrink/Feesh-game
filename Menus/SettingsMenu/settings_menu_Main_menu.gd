extends Control

@onready var SettingsManager = $/root/SettingManager
@onready var AudioManager = $/root/AudioManager
@onready var pause_menu = preload("res://Menus/PauseMenu/pause_menu.tscn")
@onready var pause_menu_instance = null
@onready var main = $"../../"


func _ready():
	$FullscreenButton.set_pressed_no_signal(SettingsManager.fullscreen)
	$MasterVolumeSlider.value = SettingsManager.master_volume
	$MusicVolumeSlider.value = SettingsManager.music_volume
	$EffectsVolumeSlider.value = SettingsManager.effects_volume

func _process(delta):
	pass

func _on_back_button_pressed():
	main.showSettingsMenu()
	#SettingsManager.save_config()
	

func _on_fullscreen_button_toggled(button_pressed):
	SettingsManager.fullscreen = button_pressed
	SettingsManager.initialize_video()


func _on_master_volume_slider_value_changed(value):
	$MasterVolumeSlider/Label.text = str(value)
	SettingsManager.master_volume = value
	SettingsManager.initialize_audio()

func _on_music_volume_slider_value_changed(value):
	$MusicVolumeSlider/Label.text = str(value)
	SettingsManager.music_volume = value
	SettingsManager.initialize_audio()

func _on_effects_volume_slider_value_changed(value):
	$EffectsVolumeSlider/Label.text = str(value)
	SettingsManager.effects_volume = value
	SettingsManager.initialize_audio()

#
#
#func _on_voices_volume_slider_value_changed(value):
	#$VoicesVolumeSlider/Label.text = str(value)
	#SettingsManager.voices_volume = value
	#SettingsManager.initialize_audio()


func _on_master_volume_slider_drag_ended(_value_changed):
	pass


func _on_music_volume_slider_drag_ended(_value_changed):
	pass


func _on_effects_volume_slider_drag_ended(_value_changed):
	pass

#
#func _on_voices_volume_slider_drag_ended(_value_changed):
	#AudioManager.play_test_sfx("Voices")
