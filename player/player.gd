extends KinematicBody2D

class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var collision =$CollisionShape2D

export (int) var speed = 300



#onready var target = position
var velocity = Vector2.ZERO
var movmentArray = []
var move =false
var indexOfMov = 0

func _physics_process(delta):
	if (move ==true && movmentArray.size()>0):
		for i in get_slide_count():
			var collision = get_slide_collision(i)
		velocity = (movmentArray[indexOfMov] - position).normalized() * speed
		# rotation = velocity.angle()
		if (movmentArray[indexOfMov] - position).length() > 5:
			velocity = move_and_slide(velocity)
		else:
			if (indexOfMov< movmentArray.size()-1):
				indexOfMov+=1




func _on_Button_pressed():
	move = true


func _on_lineDrawer_mypath_created(path):
	movmentArray = path#  # Replace with function body.




func _on_move_pressed():
	move = true # Replace with function body.
