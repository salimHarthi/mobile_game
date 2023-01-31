extends Area2D


signal _on_get_a_point()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_good_body_entered(body):
	if body is Player:
		emit_signal("_on_get_a_point")
		self.queue_free()
		
	if body is InnerWals:
		body.set_cellv(body.world_to_map(self.global_position),-1)
