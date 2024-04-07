extends Node

var goofySoundChance = 15

var playerVelocity = 250
var playerHealth = 200
var playerDefense = 0
var playerXp = 0
var playerLevel = 1
var playerXpToLevel = 100

var biteDamage = 50
var biteArmorPen = 0.4
var tailWhipDamage = 35
var tailWhipArmorPen = 0.6
var dashDamage = 25
var dashArmorPen = 0.8

var turtleVelocity = 100
var turtleHealth = 150
var turtleDefense = 0.2
var turtleLerp = 3
var turtleDamage = 10
var turtleXp = 10

var jellyVelocity = 50
var jellyHealth = 50
var jellyDefense = 0.0
var jellyLerp = 1
var jellyDamage = 1
var jellyXp = 5

var eelVelocity = 275
var eelHealth = 100
var eelDefense = 0.0
var eelLerp = 1
var eelDamage = 5
var eelXp = 15

var prevScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
