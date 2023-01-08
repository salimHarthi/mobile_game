extends Label


func _ready():
	self.text = str($"..".time)





func _on_scoreBord__on_send_score(time, score):
	self.text = str($"..".time)
