extends Node2D

export var mainGameScene : PackedScene
export var optionsGameScene : PackedScene

var nBalls

# Sound Nodes
onready var MainMenuSound = get_node("MainMenu")

func _ready():
	MainMenuSound.play()
	
func _on_PlayButton_button_up():
	MainMenuSound.stop()
	get_tree().change_scene_to(mainGameScene)

func _on_MainMenu_finished():
	MainMenuSound.play()
