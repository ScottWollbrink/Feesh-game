extends Node

@onready var dashCollision = $DashHitBox/CollisionShape2D

func _ready():
	deactivate()

# Function to activate the bite attack
func activate():
	self.visible = true
	dashCollision.disabled = false

# Function to deactivate the bite attack
func deactivate():
	self.visible = false
	dashCollision.disabled = true
