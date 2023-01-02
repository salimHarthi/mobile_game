extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_denger_blocs_body_entered(body):
	if body is Player:
		get_tree().reload_current_scene()
	if body is Bordar:
		body.set_cellv(body.world_to_map(self.global_position),-1)
