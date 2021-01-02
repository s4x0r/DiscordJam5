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


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		
		var viewsize = get_viewport_rect().size
		var dir = Vector2(event.position.x-viewsize.x/2,event.position.y-viewsize.y/2)
		#print(to_local(event.position))
		var bullet = $KinematicBody2D.duplicate()
		get_parent().add_child(bullet)
		bullet.dir = dir
		bullet.moving = true
	pass # Replace with function body.
