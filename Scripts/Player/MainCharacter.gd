extends CharacterBody2D

@onready var _animationPlayer = $MainCharacterAnimation
@onready var _playerVelocity = GlobalVars.playerVelocity
@onready var _playerHealth = GlobalVars.playerHealth
@onready var _playerDefense = GlobalVars.playerDefense
@onready var _cooldownTimer = $BiteAttack/CooldownTimer
@onready var _cosmeticTimer = $BiteAttack/CosmeticTimer
@onready var _bite = $BiteAttack
@onready var _biteAnimation = $BiteAttack/BiteAnimation

var isLeft = false
var isRight = false
var facingLeft = false
var isReady: bool = true

func _ready():
	_animationPlayer.play("move")

func _process(delta):
	if (_playerHealth <= 0):
		visible = false # stub
		print("player has died")
		
	if Input.is_action_just_pressed("bite") and isReady:
		isReady = false
		_bite.activate()
		_cooldownTimer.start()
		_cosmeticTimer.start()
		
func take_damage(dmgValue: float, armorPen: float):
	dmgValue *= 1 - (_playerDefense * (1 - armorPen))
	_playerHealth -= dmgValue
	print("Player Health: ", _playerHealth)

func _physics_process(delta):
	move_character()

func move_character():
	# Determine movement direction based on original code
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Check movement input and set direction flags~
	if Input.is_action_just_pressed("move_right"):
		isRight = true
		isLeft = false
		
	elif Input.is_action_just_pressed("move_left"):
		isRight = false
		isLeft = true

	if isLeft and !facingLeft:
		scale.x *= -1
		facingLeft = true
		emit_signal("facing_direction_changed", scale.x > 0)
		isLeft = false
	elif isRight and facingLeft:
		scale.x *= -1
		facingLeft = false
		emit_signal("facing_direction_changed", scale.x > 0)
		isRight = false
	
	velocity = direction * _playerVelocity
		
	move_and_slide()

func _on_hurt_box_area_entered(area):
	if area == null or area.readyToDmg == null or area.readyToDmg == false:
		pass
	
	area.readyToDmg = false
	area.get_node("HitBoxTimer").start()
	take_damage(area.damage, area.armorPen)


func _on_cooldown_timeout():
	isReady = true


func _on_cosmetic_timer_timeout():
	_bite.deactivate()
