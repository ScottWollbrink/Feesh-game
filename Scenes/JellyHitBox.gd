extends Area2D

@export var damage = GlobalVars.jellyDamage
@export var armorPen = 0
@export var hasSlow = true
@export var readyToDmg = true

@onready var _damageSound = get_node("/root/Game/AudioManager/StingSFX")
@onready var _damageSoundGoofy = get_node("/root/Game/AudioManager/StingSFXGoofy")
@onready var _goofySoundChance = GlobalVars.goofySoundChance

func _init() -> void:
	pass

func play_damage_sound(playerPosition):
	_damageSound.position = playerPosition
	if (randi() % 100 < _goofySoundChance):
		_damageSoundGoofy.position = playerPosition
		_damageSoundGoofy.play()
	else:
		_damageSound.position = playerPosition
		_damageSound.play()

func _on_hit_box_timer_timeout():
	readyToDmg = true

