extends Button


func _ready():
	var button = Button.new()
	button.text = "reset"
	button.connect("pressed", self, "_button_pressed")
	add_child(button)

func _button_pressed():
	get_tree().reload_current_scene()
