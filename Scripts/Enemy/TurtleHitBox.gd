extends Area2D

@export var damage = GlobalVars.turtleDamage
@export var armorPen = 0
@export var hasSlow = false
@export var readyToDmg = true

@onready var _damageSound = get_node("/root/Game/AudioManager/TurtleSFX")

func _init() -> void:
	pass

func play_damage_sound(playerPosition):
	_damageSound.position = playerPosition
	_damageSound.play()

func _on_hit_box_timer_timeout():
	readyToDmg = true
