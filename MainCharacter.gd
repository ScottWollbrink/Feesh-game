extends CharacterBody2D

@onready var _animationPlayer = $MainCharacterAnimation

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 250
	var isLeft = velocity.x < 0
	var isRight = velocity.x > 0
	move_and_slide()
	if Input.is_action_pressed("move_right"):
		_animationPlayer.play("move")
		_animationPlayer.flip_h = !isRight
		
	elif Input.is_action_pressed("move_left"):
		_animationPlayer.flip_h = isLeft
		_animationPlayer.play("move")
		
	else:
		_animationPlayer.stop()
