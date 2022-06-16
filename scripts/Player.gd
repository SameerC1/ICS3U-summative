extends KinematicBody2D
#constants for the physics
const upmovement=Vector2(0,-1)
const gravity=20
const maxfallspeed=500
const maxspeed=400
const jumpspeed=800
const acceleration=10
var health=3
#variable to be used for moving
var movement=Vector2()
var facingright=true
var hurt=false

#will be used for the movement
func _physics_process(_delta):
	
	#used to make gravity & speed limits
	movement.y+=gravity
	
	movement.x=clamp(movement.x,-maxspeed,maxspeed)
	if movement.y>maxfallspeed:
		movement.y=maxfallspeed
	
	#used to make the sprite turn left & right
	if facingright==true:
		$playersprite.flip_h=false
	else:
		$playersprite.flip_h=true
	
	#this is to move left & right
	if Input.is_action_pressed("right"):
		movement.x+=acceleration
		facingright=true
		$playersprite.play("moving")
	elif Input.is_action_pressed("left"):
		movement.x-=acceleration
		facingright=false
		$playersprite.play("moving")
	else:
		movement.x=lerp(movement.x,0,0.1)
		$playersprite.play("idle")
	#lets you jump if you are on the floor	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			movement.y=-jumpspeed
	
	#plays jump animation in the air
	if not is_on_floor() and hurt==false:
		$playersprite.play("jump")
	
	#updates the movement
	movement=move_and_slide(movement,upmovement)	



func hit(enemyposx):
	hurt=true
	set_modulate(Color(1,0.3,0.3,0.3))
	health-=1
	movement.y=-jumpspeed*0.5
	if position.x<enemyposx:
		movement.x=-10000
	elif position.x>enemyposx:
		movement.x=+10000
	$playersprite.play("hurt")
	yield(get_tree().create_timer(0.5),"timeout")
	hurt=false


func _on_enemy_bounce_detector_body_shape_entered(body_id: int, body: Node, body_shape: int, local_shape: int) -> void:
	movement.y=-jumpspeed*0.8
