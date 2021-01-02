extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var moving = false
var dir

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		move_and_slide(dir)
	pass
