extends KinematicBody2D
#constants for physics
const upmovement=Vector2(0,-1)
const gravity=20
const maxfallspeed=100
const maxspeed=200
#variable to be used for moving
var movement=Vector2()

func _ready():
		pass#TODO


func _physics_process(delta):
	movement.y+=gravity
	
	if movement.y>maxfallspeed:
		movement.y=maxfallspeed
	if Input.is_action_pressed("right"):
		movement.x=maxspeed
	elif Input.is_action_pressed("left"):
		movement.x=-maxspeed
	else:
		movement.x=0
	movement=move_and_slide(movement,upmovement)
