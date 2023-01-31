extends KinematicBody2D

class_name Player


onready var collision =$CollisionShape2D


export(Resource) var stats

#onready var target = position
var velocity = Vector2(0, 0).rotated(rotation)
var move =false
var indexOfMov = 0
var mouseNotHeld = false;
var target = Vector2.UP


func _physics_process(delta):

	if Input.is_mouse_button_pressed(1) and mouseNotHeld and move and stats.boosts>0: # when click Left mouse button
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
			var tile_pos = collision.collider.world_to_map(position)
			tile_pos -= collision.normal  # colliding tile position
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
