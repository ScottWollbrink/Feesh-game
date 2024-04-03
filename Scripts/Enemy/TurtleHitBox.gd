extends Area2D

@export var damage = GlobalVars.turtleDamage
@export var armorPen = 0
@export var readyToDmg = true

func _init() -> void:
	pass


func _on_hit_box_timer_timeout():
	readyToDmg = true
