extends KinematicBody2D

class_name Player


onready var collision =$CollisionShape2D
onready var idleAnimation =$defult
onready var boostAnimation =$onmoving
onready var animationTimer = $animation
onready var explostion = preload("res://assets/explostion.tscn")
onready var tilemap = $"../innerWals"

export(Resource) var stats

#onready var target = position
var velocity = Vector2(0, 0).rotated(rotation)
var move =false
var indexOfMov = 0
var mouseNotHeld = false;
var target = Vector2.UP
var animation = {
	"moving":"movingAnimation",
	"startMoving":"startMovingAnimation"
}
var animationTimout = true


func _physics_process(delta):
	#_animation()
	if Input.is_mouse_button_pressed(1) and mouseNotHeld and move and stats.boosts>0: # when click Left mouse button
		_setup_timer()
		mouseNotHeld= false
		target = get_global_mouse_position()
		look_at(target)
		velocity = global_position.direction_to(target) * stats.speed
		stats.boosts -=1
	if not Input.is_mouse_button_pressed(1):
		mouseNotHeld= true
		mouseNotHeld= true
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		#look_at(velocity)
			
		# remove inner walls upon collision
		if collision.collider is InnerWals: #Bordar
			var tile_pos = tilemap.world_to_map(collision.position - collision.normal)
			var newExplostion= explostion.instance()
			newExplostion.global_position = tilemap.map_to_world(tile_pos) +Vector2(32,32)
			get_parent().call_deferred("add_child",newExplostion)
			collision.collider.set_cellv(tile_pos,-1)
			
	velocity = velocity.linear_interpolate(Vector2.ZERO, stats.friction)
	


func _on_Map__on_end_game(v_scor, v_time, won_lose):
	move=false
	stats.reset()


func _on_Map__on_end_game_start():
	move=true
	stats.reset()

func _on_get_boost_handler():
	stats.addBoost(1)

#func _animation():
#	if !animationTimout:
#		boostAnimation.play(animation.startMoving)
#	else:
#		idleAnimation.play(animation.moving)

		
		
	

func _setup_timer():
	animationTimer.start()
	boostAnimation.show()
	animationTimout=false
	
func _on_animation_timeout():
	animationTimout=true
	boostAnimation.hide()
