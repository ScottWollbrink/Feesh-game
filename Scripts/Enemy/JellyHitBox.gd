extends Area2D

@export var damage = GlobalVars.jellyDamage
@export var armorPen = 0
@export var hasSlow = true
@export var readyToDmg = true

@onready var _goofySoundChance = GlobalVars.goofySoundChance

func _init() -> void:
	pass

func play_damage_sound(playerPosition):
	if (randi() % 100 < _goofySoundChance):
		AudioManager.stingSfxGoofy.position = playerPosition
		AudioManager.stingSfxGoofy.play()
	else:
		AudioManager.stingSfx.position = playerPosition
		AudioManager.stingSfx.play()

func _on_hit_box_timer_timeout():
	readyToDmg = true

