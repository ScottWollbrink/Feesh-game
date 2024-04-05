extends CharacterBody2D

@onready var player = get_node("/root/Game/MainCharacter")
@onready var _jellyVelocity = GlobalVars.jellyVelocity
@onready var _jellyLerp = GlobalVars.jellyLerp
@onready var _animationPlayer = $AnimationPlayer
@onready var _jellyDefense = GlobalVars.jellyDefense
@onready var _jellyHealth = GlobalVars.jellyHealth
@onready var _healthBar = $HealthBar
@onready var _hideHealthBarTimer = $HealthBar/HideHealthBarTimer
@onready var _jellyXp = GlobalVars.jellyXp
@onready var _softCollisions = $SoftCollision

var maxHealth: float

func _ready():
	_healthBar.set_max(_jellyHealth)
	_healthBar.value = _jellyHealth
	_healthBar.visible = false
	_animationPlayer.play("swimming")
	maxHealth = _jellyHealth

func _process(delta):
	if (_jellyHealth <= 0):
		visible = false # stub
		player.get_xp(_jellyXp)
		queue_free()
		
	if (_healthBar.visible == true and _healthBar.value >= maxHealth):
		_hideHealthBarTimer.start()

func take_damage(dmgValue: float, armorPen: float):
	dmgValue *= 1 - (_jellyDefense * (1 - armorPen))
	_jellyHealth -= dmgValue
	_animationPlayer.stop()
	_animationPlayer.play("hurt")
	_animationPlayer.queue("swimming")
	_healthBar.value = _jellyHealth
	_healthBar.visible = true

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = Vector2(move_toward(velocity.x, direction.x * _jellyVelocity, _jellyLerp), move_toward(velocity.y, direction.y * _jellyVelocity, _jellyLerp))
	var isLeft = velocity.x < 0
	var isRight = velocity.x > 0
	
	if isRight:
		$JellyfishSprite.flip_h = false
	elif isLeft:
		$JellyfishSprite.flip_h = true
		
	if _softCollisions.is_colliding():
		velocity += _softCollisions.get_push_vector() * delta * 400
	move_and_slide()

func _on_hurt_box_area_entered(area):
	if area == null:
		pass
		
	take_damage(area.damage, area.armorPen)


func _on_hide_health_bar_timer_timeout():
	_healthBar.visible = false
	_hideHealthBarTimer.stop()

