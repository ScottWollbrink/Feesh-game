extends Node

@onready var _animationBite = $BiteAnimation
@onready var biteCollision = $BiteHitBox/CollisionShape2D

func _ready():
	_animationBite.play("default")
	deactivate()

# Function to activate the bite attack
func activate():
	self.visible = true
	biteCollision.disabled = false

	# await(get_tree().create_timer(0.2))  # Adjust the delay as needed
	# deactivate()

# Function to deactivate the bite attack
func deactivate():
	self.visible = false
	biteCollision.disabled = true
