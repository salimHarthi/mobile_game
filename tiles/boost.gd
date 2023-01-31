extends Area2D
class_name Boost
signal _on_get_boost()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_boost_body_entered(body):
	if body is Player:
		emit_signal("_on_get_boost")
		self.queue_free()
	if body is InnerWals:
		body.set_cellv(body.world_to_map(self.global_position),-1)
