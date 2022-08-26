extends Node

#Parameters for Generator
export var totalBalls = 60
export var LINES = 3
export var ROWS = 5

#Hash for card numbers
var cardNumbers = {}
var rng = RandomNumberGenerator.new()

func _ready():
	generateNewSeed()
	generateCardNumbers()

# Getters
func getCardNumbers():
	return cardNumbers

# Generate Functions
func generateNewSeed():
	rng.randomize()

func generateCardNumbers():
	var allCardNumbers = []

	# Grab all numbers for the card
	for _l in range(LINES):
		for _r in range(ROWS):
			var number = getRandomNumber(allCardNumbers)
			
			allCardNumbers.push_back(number)
	
	# Sort them from smallest to biggest
	allCardNumbers.sort()
	
	# Re arrange them by lines
	for l in range(LINES):
		var line = {}
		for _r in range(ROWS):
			var number = allCardNumbers.pop_front()
			line[number] = false
			
		cardNumbers[l] = {line = line, isLineChecked = false}
		

func getRandomNumber(list):
	var number = rng.randi_range(1, totalBalls)

	if list.has(number):
		return getRandomNumber(list)

	return number
