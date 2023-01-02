extends Line2D

signal mypath_created(path)


onready var parent : Node = get_node("../player")


onready var array = PoolVector2Array( [parent.global_position] )
onready var drawArray = PoolVector2Array( [self.global_position] )

var iscoliding =false

var color_red = Color(255,0,0)
var color_green = Color(0,255,0)
var canDeaw = true
#var array_color = PoolColorArray(color_green)


#func _process(delta):
#	pass
	

func _input(event):
	if event is InputEventMouseButton and event.pressed and canDeaw:
		var mousePos = get_global_mouse_position()
		var space = get_world_2d().direct_space_state
		var collision_objects = space.intersect_point(mousePos, 1)
		if collision_objects and (collision_objects[0].collider is Bordar or collision_objects[0].collider is StaticBody2D):
			pass
		else:
			addtoArray(get_global_mouse_position())
			
			update()
			emit_signal("mypath_created",array)




# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position =self.to_local(parent.global_position)


func _draw():
	draw_multiline(drawArray,color_green, 1)

func _on_move_pressed():
	canDeaw = false

func addtoArray(value):
	array.append(value)
	array.append(value)
	drawArray.append(self.to_local(value))
	drawArray.append(self.to_local(value))
	
