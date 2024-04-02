extends CharacterBody2D

@onready var player = get_node("/root/Game/MainCharacter")
@onready var _animationPlayer = $TurtleAnimation

func _physics_process(delta):
	print(player.global_position)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 150
	var isLeft = velocity.x < 0
	var isRight = velocity.x > 0
	
	if isRight:
		_animationPlayer.flip_h = false
	elif isLeft:
		_animationPlayer.flip_h = true
	
	move_and_slide()
