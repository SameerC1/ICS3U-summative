extends Node2D

#will change to victory is the castle is reached
func _on_Area2D_body_shape_entered(body_id: int, body: Node, body_shape: int, local_shape: int) -> void:
	get_tree().change_scene("res://scenes/victory.tscn")
