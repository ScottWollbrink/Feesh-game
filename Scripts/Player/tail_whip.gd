extends Node

@onready var _animationTailWhip = $TailWhipAnimation
@onready var tailwhipCollision = $TailWhipHitBox/CollisionShape2D

func _ready():
	_animationTailWhip.play("tailwhip")
	deactivate()

# Function to activate the bite attack
func activate():
	self.visible = true
	tailwhipCollision.disabled = false

# Function to deactivate the bite attack
func deactivate():
	self.visible = false
	tailwhipCollision.disabled = true
