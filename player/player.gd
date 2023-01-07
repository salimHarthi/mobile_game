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

export (float) var speed = 400
export (float) var friction = 0.01


#onready var target = position
var velocity = Vector2(0, 0).rotated(rotation)
var movmentArray = []
var move =false
var indexOfMov = 0

func _physics_process(delta):
	if Input.is_mouse_button_pressed(1): # when click Left mouse button
		var target = get_global_mouse_position()
		velocity = global_position.direction_to(target) * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
	velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
			
#	if (move ==true && movmentArray.size()>0):
#		for i in get_slide_count():
#			var collision = get_slide_collision(i)
#		velocity = (movmentArray[indexOfMov] - position).normalized() * speed
#		# rotation = velocity.angle()
#		if (movmentArray[indexOfMov] - position).length() > 5:
#			velocity = move_and_slide(velocity)
#		else:
#			if (indexOfMov< movmentArray.size()-1):
#				indexOfMov+=1




func _on_Button_pressed():
	move = true


func _on_lineDrawer_mypath_created(path):
	movmentArray = path#  # Replace with function body.




func _on_move_pressed():
	move = true # Replace with function body.
