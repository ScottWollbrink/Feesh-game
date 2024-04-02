extends Node

@onready var _animationBite = $BiteAnimation
@onready var biteCollision = $BiteCollision

# Function to activate the bite attack
func activate():
	_animationBite.visible = true
	biteCollision.disabled = false

	# Implement logic for the bite attack, such as dealing damage to enemies
	# if touching enemy hitbox
	# 	deal x damage
	# After the attack, hide the bite sprite and disable collision shape
	await(get_tree().create_timer(0.2))  # Adjust the delay as needed
	deactivate()

# Function to deactivate the bite attack
func deactivate():
	_animationBite.visible = false
	biteCollision.disabled = true
