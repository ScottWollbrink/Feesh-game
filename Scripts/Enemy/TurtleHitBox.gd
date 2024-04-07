extends Area2D

@export var damage = GlobalVars.turtleDamage
@export var armorPen = 0
@export var hasSlow = false
@export var readyToDmg = true


func _init() -> void:
	pass

func play_damage_sound(playerPosition):
	AudioManager.turtleSfx.position = playerPosition
	AudioManager.turtleSfx.play()

func _on_hit_box_timer_timeout():
	readyToDmg = true
