extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	


func _on_Map_on_send_score(val):
	self.text = str(val)
