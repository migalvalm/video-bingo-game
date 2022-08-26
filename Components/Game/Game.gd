extends Node2D

# Object Nodes
var ballScene = preload("res://Components/Ball/Ball.tscn")
var endGameScene = load("res://Components/Menu/EndGame/EndGame.tscn")

onready var BallsGenerator = get_node("BallNumberGenerator")
onready var Card = get_node("Card")

# Script nodes
onready var timer = get_node("Timer")

# Sound nodes
onready var StartGameSound = get_node("StartGame")

# Info nodes
onready var BallNumberInfo = get_node("GameStats/BallNumber/Text")
onready var UsedBallNumberInfo = get_node("GameStats/ExtractedBalls/Text")
onready var LinesInfo = get_node("GameStats/Lines/Text")

var GAME_STATE = { BINGO = "BINGO", 
	DEFEAT = {
		0: "DEFEAT",
		1: "DEFEAT_WITH_1_LINE",
		2: "DEFEAT_WITH_2_LINES"
	}
}

var GAME_STATES = {
	BINGO = "BINGO",
	DEFEAT = "DEFEAT",
	DEFEAT_WITH_1_LINE = "DEFEAT_WITH_1_LINE",
	DEFEAT_WITH_2_LINEs = "DEFEAT_WITH_2_LINES"
}

var ball = null
	
func _ready():
	StartGameSound.play()
	spawnBall()
	
func endGame(state):
	get_tree().paused = true
	var endGame = endGameScene.instance()
	endGame.setState(state)
	
	add_child(endGame)

func spawnBall():
	Card.isCardComplete()
	
	ball = ballScene.instance()
	
	ball.setNumber(BallsGenerator.getNextBallNumber())
	add_child(ball)
	
	updateBallInfo()

func updateBallInfo():
	if ball:
		BallNumberInfo.text = str(ball.getNumber())
	
	LinesInfo.text = str(Card.getLinesCompleted())
	UsedBallNumberInfo.text = str(BallsGenerator.getExtractedBalls())

func _on_Area2D_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if timer.time_left <= 0:
		ball = body
		var ballNumber = body.getNumber()

		Card.checkNumber(ballNumber)
		
		updateBallInfo()

		timer.start(3.0)
		

func _on_Timer_timeout():
	remove_child(ball)
	spawnBall()

func _on_Card_bingo():
	endGame(GAME_STATE.BINGO)

func _on_BallNumberGenerator_extraction_complete():
	endGame(GAME_STATE.DEFEAT[Card.getLinesCompleted()])
