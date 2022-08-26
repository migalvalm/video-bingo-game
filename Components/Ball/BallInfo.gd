extends Node2D

var COLORS = {
	Blue = Rect2(197, 332, 43, 43),
	Green = Rect2(255, 332, 43, 43),
	Pearl = Rect2(312, 332, 43, 43),
	Yellow = Rect2(370, 332, 43, 43),
	Red = Rect2(197, 419, 43, 43),
	Pink = Rect2(255, 419, 43, 43),
	Orange = Rect2(312, 419, 43, 43),
	Purple = Rect2(370, 419, 43, 43)
}
export var rotation_speed = PI
export var number = 1;


func _ready():
	$BallSprite.region_rect = getColorByNumber()

func setNumber(value):
	number = value
	setNumberTxt()

func setNumberTxt():
	$BallSprite.get_child(0).text = str(number)
	
func getColorByNumber():
	if range(1, 11, 1).has(number):
		return COLORS.Blue
	elif range(12, 21, 1).has(number):
		return COLORS.Green
	elif range(22, 31, 1).has(number):
		return COLORS.Pearl
	elif range(32, 41, 1).has(number):
		return COLORS.Yellow	
	elif range(42, 51, 1).has(number):
		return COLORS.Red
	elif range(52, 61, 1).has(number):
		return COLORS.Pink
	elif range(62, 71, 1).has(number):
		return COLORS.Orange
	else:
		return COLORS.Purple
