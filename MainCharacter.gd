extends CharacterBody2D

@onready var _animationPlayer = $MainCharacterAnimation
@onready var _playerVelocity = GlobalVars.playerVelocity

var isLeft = false
var isRight = false

func _physics_process(delta):
	move_character()

func move_character():
	# Determine movement direction based on original code
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Check movement input and set direction flags
	if Input.is_action_just_pressed("move_right"):
		isRight = true
		isLeft = false
		_animationPlayer.play("move")
	elif Input.is_action_just_pressed("move_left"):
		isLeft = true
		isRight = false
		_animationPlayer.play("move")
	else:
		# Stop animation only when no movement keys are pressed
		_animationPlayer.stop()

	# Flip character horizontally based on direction
	if isLeft:
		_animationPlayer.flip_h = true
	elif isRight:
		_animationPlayer.flip_h = false

	velocity = direction * _playerVelocity
	move_and_slide()
