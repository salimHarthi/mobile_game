extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal _on_send_score(time,score,won_lose)

var score = 0
var time = "0:0:0"

func _ready():
	pass # Replace with function body.
#func _on_get_score_and_time(v_scor,v_time):
#	score = v_scor
#	time = v_time

#func _show_game_end():
#	emit_signal("_on_send_score",score,time)
#	self.show()
#	print("game end")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Map__on_end_game(v_scor, v_time,won_lose):
	score = "Score: " +str(v_scor)
	time = "Time: "+str(v_time)
	emit_signal("_on_send_score",score,time,won_lose)
	self.show()
	print("game end")
