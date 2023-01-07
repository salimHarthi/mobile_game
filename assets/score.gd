extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var maps = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(0)+"/"+str(maps.max_number_of_good)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	


func _on_Map_on_send_score(val):
	self.text = str(val)+"/"+str(maps.max_number_of_good)
