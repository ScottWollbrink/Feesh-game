extends CharacterBody2D

@export var facing_left_position: Vector2 = Vector2(-29, 0)
@export var facing_right_position: Vector2 = Vector2(29, 0)

func _ready():
	get_parent().connect("facing_direction_changed", on_player_facing_direction_changed)
	
func on_player_facing_direction_changed(facing_right: bool):
	if (facing_right):
		position = facing_right_position
	else:
		position = facing_left_position
	
