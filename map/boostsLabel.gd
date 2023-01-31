extends Label

export(Resource) var playerState

func _ready():
	self.text = "boosts"+str(playerState.boosts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text ="boosts: "+str(playerState.boosts)

	



