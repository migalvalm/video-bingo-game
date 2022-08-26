extends Node2D

export var mainGameScene : PackedScene
export var mainMenuScene : PackedScene

# Sound nodes
onready var BingoSound = get_node("Bingo")
onready var DefeatSound = get_node("Defeat")

onready var StateText = $Layer/MarginContainer/VBoxContainer/StateText

var GAME_STATES = {
	BINGO = "BINGO",
	DEFEAT = "DEFEAT",
	DEFEAT_WITH_1_LINE = "DEFEAT_WITH_1_LINE",
	DEFEAT_WITH_2_LINES = "DEFEAT_WITH_2_LINES"
}

var state = null

func _ready():
	match state:
		GAME_STATES.BINGO:
			StateText.text = "Bingo!"
			BingoSound.play()
		GAME_STATES.DEFEAT_WITH_2_LINES:
			StateText.text = "Almost there!"
			DefeatSound.play()
		GAME_STATES.DEFEAT_WITH_1_LINE:
			StateText.text = "So far away!"
			DefeatSound.play()
		GAME_STATES.DEFEAT:
			StateText.text =  "You lost!"
			DefeatSound.play()

func setState(newState):
	state = newState

func _on_YesButton_button_up():
	get_tree().paused = false
	get_tree().change_scene_to(mainGameScene)

func _on_NoButton_button_down():
	get_tree().paused = false
	get_tree().change_scene_to(mainMenuScene)
