extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var child = self.duplicate()
	get_parent().add_child(child)
	var r= int(rand_range(1,3))
	for i in child.get_children():
		if i.name == 'face'+str(r):
			i.show()
		elif 'face' in i.name:
			i.hide()
	child.move_and_slide(Vector2(5000, 5000))
	move_and_slide(Vector2(5000, 0))
	pass # Replace with function body.


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
