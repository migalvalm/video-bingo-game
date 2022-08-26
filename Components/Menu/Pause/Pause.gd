extends Control

# Sound nodes
onready var ContinueGameSound = get_node("ContinueSound")
onready var PauseGameSound = get_node("PauseSound")

var isGameFinished = false

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("ui_cancel") && !isGameFinished || event.is_action_pressed("ui_accept") && !isGameFinished:
		$Background.visible = !$Background.visible
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			PauseGameSound.play(0.28)
		else: 
			ContinueGameSound.play()
			
