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
		movement.x=lerp(movement.x,0,0.2)
		$playersprite.play("idle")
	#lets you jump if you are on the floor	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			movement.y=-jumpspeed
	
	#plays jump animation in the air
	if not is_on_floor():
		$playersprite.play("jump")
	
	#updates the movement
	movement=move_and_slide(movement,upmovement)



func _on_enemy_bounce_detector_area_shape_entered(area_id: int, area: Area2D, area_shape: int, local_shape: int) -> void:
	movement.y=-jumpspeed*0.8
	

func _on_hit_detector_area_entered(area: Area2D) -> void:
	self.hit(position.x)

func hit(enemyposx):
	set_modulate(Color(1,0.3,0.3,0.3))
	health-=1
	if position.x>enemyposx:
		movement.x=-500
	else:
		movement.x=+500
	movement.y=-jumpspeed*0.5
	$playersprite.play("hurt")
