extends KinematicBody2D
var health=3
var movement=Vector2()
const gravity=20
const maxspeed=200
const maxfallspeed=400
const upmovement=Vector2(0,-1)
var direction=1


func ready():
	$Enemybody.flip_h=false
	$FloorChecker.position.x=$hitbox.shape.get_extents().x*direction

func _physics_process(_delta):
	#used to make gravity & speed limits
	
	movement.y+=gravity
	if movement.y>maxfallspeed:
		movement.y=maxfallspeed

	
	#used to make the sprite turn left & right
	#makes enemy turn & move
	if is_on_wall() or not $FloorChecker.is_colliding() and is_on_floor():
		direction=direction*-1
		$Enemybody.flip_h=not $Enemybody.flip_h
		$FloorChecker.position.x=$hitbox.shape.get_extents().x*direction
	movement.x=50*direction
	movement=move_and_slide(movement,upmovement)
	$Enemybody.play("moving")
	
#function for if it is stomped
func _on_Area2D_body_entered(body: Node) -> void:
	$Enemybody.play("hurt")

