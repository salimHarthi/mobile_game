extends Resource
class_name PlayerResource
export (float) var speed = 400
export (float) var friction = 0.01
export (int) var boosts = 5


func reset():
	speed = 400
	friction = 0.01
	boosts = 5

func addBoost(val):
	boosts+=val
