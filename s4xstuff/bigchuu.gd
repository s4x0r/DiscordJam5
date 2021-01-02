extends KinematicBody2D


var stats={
	'type':'enemy',
	'hp':100,
	'living':true,
	'strength':10,
	'defense':10,
	'element':'electric',
	'breedrate':10,
	'love':0,
	'attention':10,
	'speed':100,
	'friction':150
}
var direction=Vector2(0,0)
var velocity
var boredom =0

func dicepool(number, value, dc):
	var dice = []
	var out = 0
	
	for i in range(number):
		dice.append(randi()%value)
	for i in dice:
		if i >= dc:
			out = out+1
	#print('roll')
	return out
	
#I'm going to take his face
#...   off
func changeface(face):
	remove_child($face)
	add_child(face)
	face.name = 'face'

func getface():
	return $face

func kick(force):
	direction=Vector2(randi()%-force+force,randi()%-force+force)
	pass

func damage(x):
	stats['hp']=stats['hp']-x
	if(stats['hp']<=0):
		stats['living']=false
		killme()
	pass

func mutate(dic1, dic2):
	var out={}
	if dic1['type'] != dic2['type']:
		print('type mismatch')
		return 
	out['type']=dic1['type']
	for i in dic1.keys():
		if typeof(dic1[i]) == typeof(int(1)):
			out[i]= (dic1[i]+randi()%-5+5)+(dic2[i]+randi()%-5+5)/2
			pass
		elif typeof(dic1[i]) == typeof('string'):
			var j =[dic1[i],dic2[i]]
			out[i]=j[randi() % j.size()]
			pass
	return out


func killme():
	get_parent().remove_child(self)
	pass
	
func breed():
	var mate
	var bodies=$Area2D.get_overlapping_areas()
	for i in bodies:
		if i.get_parent() == self:
			pass
		elif i.get_parent().stats['type'] == stats['type']:
			mate = i.get_parent()
			#print(mate.stats)
			stats['love']=stats['love'] + dicepool(6,6,4)
		pass
		
	
	if stats['love'] > stats['breedrate']:
		#print("lovemode")
		#inherit body from "father"
		var child = self.duplicate()
		get_parent().add_child(child)
		#inherit face from "mother"
		child.changeface(mate.getface().duplicate())
		#new stats = mutate parents's stats
		child.stats=mutate(stats, mate.stats)
		stats['love']=0
		kick(stats['speed']/10)
		print('baby')
		pass


# Called when the node enters the scene tree for the first time.
func _ready():
	#kick(stats['speed'])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	#move_and_slide(direction)
#
#
#	 # Get velocity
#	var velocity = stats['speed']/100 * delta * direction # move slow? increases speed or multiply this x 100
#   # move and slide:	
#	move_and_collide(velocity)
#	direction=direction-direction/stats['friction']
#   # check if there is a collision:
#	if get_slide_count() > 0:
#		var collision = get_slide_collision(0)
#		print(collision)
#		if collision != null:
#			direction = -collision.position # do ball bounce
	pass
func _physics_process(delta):
	var collision = null
	
		#velocity.y += WALK_SPEED * ud * delta
	velocity = direction*stats['speed']/10
	
	direction = direction-direction/stats['friction'] 	#Player slides, how cool.
	
	collision = move_and_collide(velocity)
	if collision != null:
		#S$AudioStreamPlayer.play()
		velocity = -velocity/2	#Player bounces in opposite direction
		move_and_slide(velocity)
	velocity=velocity-velocity/stats['friction'] 
#	pass


func _on_Timer_timeout():
	breed()
	boredom = boredom+dicepool(6,6,4)
	if boredom > stats['attention']:
		print('kick')
		kick(1)
		boredom=0
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	#direction = -body.position*stats['speed']/10
	pass # Replace with function body.
