extends Container

var number = 0
var checked = false
	

# Setters
func setNumber(value):
	number = value
	get_node("Number").text = str(number)

func setChecked(value): 
	checked = value
	if checked ==  true: 
		$Element/Border.border_color = "#0d28d4"
