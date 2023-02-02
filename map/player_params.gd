extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var boxes = $HBoxContainer

onready var images = preload("res://assets/boostcountimage.tscn")

export(Resource) var stats
var listOfBoosts = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in stats.boosts:
		var x = images.instance()
		listOfBoosts.append(x)
		boxes.add_child(x)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_get_boost_handler():
	var x = images.instance()
	listOfBoosts.append(x)
	boxes.add_child(x)


func _on_player__on_click():
	var x = listOfBoosts.pop_back()
	if x:
		x.queue_free()
