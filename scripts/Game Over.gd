extends CanvasLayer

onready var title=$PanelContainer/MarginContainer/Rows/titletext

func set_title(win:bool):
	if win:
		title.text="YOU WIN!"
	else:
		title.text="YOU LOSE"

func _on_Retry_pressed() -> void:
	get_tree().change_scene("res://scenes/level.tscn")



func _on_Quit_pressed() -> void:
	get_tree().quit()
