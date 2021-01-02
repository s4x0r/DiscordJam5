extends KinematicBody2D

signal damaged
signal pickup
var item_uses = 0
var crowbar = false

const GRAVITY = 200.0
const WALK_SPEED = 3.5
const FRICTION = 0.95	#Friction mechanism may be improved, see line 38
var collision
var velocity = Vector2()

func pickup(item):
	emit_signal("pickup", item)
	item_uses=5
	
	if item == "crowbar":
		crowbar = true
		$crowbar.show()
		pass
	elif item == "flashlight":
		pass
	pass

func _physics_process(delta):
	collision = null
	var lr = Input.is_action_pressed("ui_right") as int - Input.is_action_pressed("ui_left") as int
	var ud = Input.is_action_pressed("ui_down") as int - Input.is_action_pressed("ui_up") as int
	
	if lr:	#If lr (left/right) is nonzero
		if lr == 1:	#right - left == 1 if left is not pressed
			$AnimatedSprite.play('right')
		else:	#Else it would be left
			$AnimatedSprite.play('left')
		velocity.x += WALK_SPEED * lr * delta
		
	if ud:	#If ud (Up/Down) is nonzero
		if ud == 1:	#down - up == 1 if up is not pressed
			$AnimatedSprite.play('down')
		else:	#Else it would be up
			$AnimatedSprite.play('up')
		velocity.y += WALK_SPEED * ud * delta
	
	if !(lr|ud):	
		$AnimatedSprite.stop()
	
	if abs(velocity.x)>WALK_SPEED:
		velocity.x -= WALK_SPEED / velocity.x
	if abs(velocity.y)>WALK_SPEED:
		velocity.y -= WALK_SPEED / velocity.y
	
	velocity *= FRICTION 	#Player slides, how cool.
	
	collision = move_and_collide(velocity)
	if collision != null:
		$AudioStreamPlayer.play()
		if not collision.collider.get_parent().get("moveable")==null:
			if item_uses > 0:
				item_uses-1
				if crowbar:
					collision.collider.get_parent().get_parent().remove_child(collision.collider.get_parent())
				else:
					emit_signal("damaged", self)
				if item_uses==0:
					crowbar = false
					$crowbar.hide()
			else:
				collision.collider.get_parent().position += velocity*8
				
		velocity = -velocity*2	#Player bounces in opposite direction
		#move_and_collide(velocity)
