extends Sprite


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
	var r= int(rand_range(1,3))
	for i in get_children():
		if i.name == 'face'+str(r):
			i.show()
		elif 'face' in i.name:
			i.hide()
	child.position+=Vector2(rand_range(50, 100),rand_range(50, 100))
	pass # Replace with function body.
