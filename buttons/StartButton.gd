extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1) and event.pressed :
		print("Clicked")
		get_tree().reload_current_scene()
