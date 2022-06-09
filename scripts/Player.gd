extends KinematicBody2D
#constants for the physics
const upmovement=Vector2(0,-1)
const gravity=20
const maxfallspeed=500
const maxspeed=400
const jumpspeed=600
const acceleration=10
#variable to be used for moving
var movement=Vector2()
var facingright=true
func _ready():
		pass#TODO

#will be used for the movement
func _physics_process(_delta):
	
	#used to make gravity & speed limits
	movement.y+=gravity
	movement.x=clamp(movement.x,-maxspeed,maxspeed)
	if movement.y>maxfallspeed:
		movement.y=maxfallspeed
	
	#used to make the sprite turn left & right
	if facingright==true:
		$body.scale.x=1
	else:
		$body.scale.x=-1
	
	#this is to move left & right
	if Input.is_action_pressed("right"):
		movement.x+=acceleration
		facingright=true
	elif Input.is_action_pressed("left"):
		movement.x-=acceleration
		facingright=false
	else:
		movement.x=lerp(movement.x,0,0.2)
	
	#lets you jump if you are on the floor	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			movement.y=-jumpspeed
	
	#updates the movement
	movement=move_and_slide(movement,upmovement)
