extends KinematicBody2D
var movement=Vector2()
const gravity=20
var speed=50
const maxfallspeed=400
const upmovement=Vector2(0,-1)
var direction=1
var hurt=false

func ready():
	$Enemybody.flip_h=false
	$FloorChecker.position.x=$hitbox.shape.get_extents().x*direction

func _physics_process(_delta):
	if hurt==false:
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
		movement.x=speed*direction
		movement=move_and_slide(movement,upmovement)
		$Enemybody.play("moving")
	
	#function for if it is stomped


func _on_hit_checker_area_shape_entered(area_id: int, area: Area2D, area_shape: int, local_shape: int) -> void:
	hurt=true
	set_modulate(Color(1,0.3,0.3,0.3))
	speed=0
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(0,false)
	$Enemybody.play("hurt")
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().queue_delete(self)
