extends CharacterBody2D

@onready var player = get_node("/root/Game/MainCharacter")
@onready var _turtleVelocity = GlobalVars.turtleVelocity
@onready var _turtleLerp = GlobalVars.turtleLerp
@onready var _animationPlayer = $TurtleAnimation
@onready var _turtleDefense = GlobalVars.turtleDefense
@onready var _turtleHealth = GlobalVars.turtleHealth


func _process(delta):
	if (_turtleHealth <= 0):
		visible = false # stub
		print("turtle has died")

func take_damage(dmgValue: float, armorPen: float):
	dmgValue *= 1 - (_turtleDefense * (1 - armorPen))
	_turtleHealth -= dmgValue
	print("Turtle Health: ", _turtleHealth)

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = Vector2(move_toward(velocity.x, direction.x * _turtleVelocity, _turtleLerp), move_toward(velocity.y, direction.y * _turtleVelocity, _turtleLerp))
	var isLeft = velocity.x < 0
	var isRight = velocity.x > 0
	
	if isRight:
		_animationPlayer.flip_h = false
	elif isLeft:
		_animationPlayer.flip_h = true
	if velocity != Vector2.ZERO:
		_animationPlayer.play("walking")
	else:
		_animationPlayer.play("idle")
	move_and_slide()

func _on_hurt_box_area_entered(area):
	if area == null:
		pass
		
	take_damage(area.damage, area.armorPen)
