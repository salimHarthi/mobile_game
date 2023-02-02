extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var score = 0
var time = "0:0:0"
onready var scoreLabel = $Panel/score
onready var timeLabel = $Panel/time
onready var wonLostLabel = $Panel/won_lose
onready var gameOver = $gameOver
func _ready():
	scoreLabel.text = ""
	timeLabel.text = ""
	wonLostLabel.text = ""
	self.hide()
	gameOver.hide()




func _on_Map__on_end_game(v_scor, v_time,won_lose):
	score = "Score: " +str(v_scor)
	print(won_lose)
	time = "Time: "+str(v_time)
	#emit_signal("_on_send_score",score,time,won_lose)
	if won_lose == "Lost":
		gameOver.show()

	else:
		scoreLabel.text = score
		timeLabel.text = time
		wonLostLabel.text = won_lose
	self.show()
