extends CanvasLayer
#functions for pressing the buttons

func _on_Retry_pressed() -> void:
	get_tree().change_scene("res://scenes/level.tscn")



func _on_Quit_pressed() -> void:
	get_tree().quit()
