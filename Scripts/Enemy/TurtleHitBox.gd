extends Area2D

@export var damage = GlobalVars.turtleDamage
@export var armorPen = 0
@export var readyToDmg = true

@onready var _damageSound = get_node("/root/Game/AudioManager/TurtleSFX")

func _init() -> void:
	pass

func play_damage_sound():
	_damageSound.play()

func _on_hit_box_timer_timeout():
	readyToDmg = true
