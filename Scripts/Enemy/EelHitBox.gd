extends Area2D

@export var damage = GlobalVars.eelDamage
@export var armorPen = 0
@export var hasSlow = false
@export var readyToDmg = true


func _init() -> void:
	pass

func play_damage_sound(playerPosition):
	AudioManager.slapSfx.position = playerPosition
	AudioManager.slapSfx.play()

func _on_hit_box_timer_timeout():
	readyToDmg = true
