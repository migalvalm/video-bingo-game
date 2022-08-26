extends Node2D

# Object nodes
var cardNumberScene = preload("res://Components/Card/CardNumber.tscn")
var cardLineScene = preload("res://Components/Card/CardLine.tscn")

# Sound nodes
onready var BallCheckSound = get_node("BallCheck")
onready var BallUncheckSound = get_node("BallUncheck")
onready var LineCheckSound = get_node("LineCheck")

# Script nodes
onready var CardGenerator = get_node("CardNumberGenerator")

#Checkers Consts
var LINE_CHECKED = [true, true, true, true, true]
var CARD_CHECKED = [true, true, true]

var cardNumbers = {}
export var LINES = 3
export var ROWS = 5
var cardLinesChecked = []

signal bingo
	

func _ready():
	setCardNumbersData(
		$CardNumberGenerator.cardNumbers, 
		$CardNumberGenerator.LINES, 
		$CardNumberGenerator.ROWS
		)

## Checkers
func isCardComplete():
	if cardLinesChecked.size() == LINES:
		emit_signal("bingo") 
		

func isAnyLineComplete():
	return cardLinesChecked.has(true)
	

## Setters
func setCardNumbersData(data, l, r):
	cardNumbers.merge(data)
	LINES = l
	ROWS = r
	
	spawnCardNumbers()

func checkNumber(value): 
	var lineNodes = get_node("Container/LinesContainer").get_children()

	var l = 0;
	for lineNode in lineNodes:
		var numbers = lineNode.get_children()
		for numberNode in numbers:
			if numberNode.number == value:
				cardNumbers[l].line[value] = true
				numberNode.setChecked(true)
				
				BallCheckSound.play()
				checkLine()
				
				return true
		l += 1
	BallUncheckSound.play() 

## Getters 
func getLinesCompleted():
	return cardLinesChecked.size()

## Setters
func checkLine():	
	for l in range(LINES):
		var line = cardNumbers[l].line
		if cardLinesChecked.has(line):
			pass
		elif line.values() == LINE_CHECKED:
			cardNumbers[l] = { line = line, isLineChecked = true }

			cardLinesChecked.push_back(line)
			LineCheckSound.play()

## Render
func spawnCardNumbers():
	for l in LINES:
		var cardLine = cardLineScene.instance()
		get_node("Container/LinesContainer").add_child(cardLine)
		
		var lineNumbers = cardNumbers[l]["line"].keys()
		lineNumbers.sort()
		for r in ROWS:
			var cardNumber = cardNumberScene.instance()
			cardNumber.setNumber(lineNumbers[r])
			
			cardLine.add_child(cardNumber)
			

func playBallUncheckSound():
	BallUncheckSound.play() 


func _on_BallUncheck_finished():
	get_node("BallUncheck").stop()

func _on_BallCheck_finished():
	get_node("BallCheck").stop()

