extends Node

export var totalBalls = 60
export var nBalls = 30
var ballsNumbers = []
var extractedBallsNumbers = []
var ballPosition = 0

var rng = RandomNumberGenerator.new()

signal extraction_complete

func _ready():
	generateNewSeed()
	generateBallNumbers()

# Getters
func getNextBallNumber():
	if getExtractedBalls() < nBalls:
		var ballNumber = ballsNumbers.pop_front()
		
		extractedBallsNumbers.push_back(ballNumber)
		
		return ballNumber
	else:
		emit_signal("extraction_complete")
		
func getExtractedBalls():
	return extractedBallsNumbers.size()

# Generate Functions
func generateNewSeed():
	rng.randomize()

func generateBallNumbers():
	for _n in range(nBalls):
		var number = getRandomNumber()
		ballsNumbers.push_back(number)

func getRandomNumber():
	var number = rng.randi_range(1, totalBalls)

	if ballsNumbers.has(number):
		return getRandomNumber()
	
	return number

