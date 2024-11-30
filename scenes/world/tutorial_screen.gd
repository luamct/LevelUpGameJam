extends TextureRect

const _01_EVENT = preload("res://assets/Tutorial Pages/Separadas/01-EVENT.png")
const _02_TRAIN = preload("res://assets/Tutorial Pages/Separadas/TRAIN certo.png")
const _03_HIRE = preload("res://assets/Tutorial Pages/Separadas/03-HIRE.png")
const _04_TRAVEL = preload("res://assets/Tutorial Pages/Separadas/04-TRAVEL.png")

var images = [
	_01_EVENT,
	_02_TRAIN,
	_03_HIRE,
	_04_TRAVEL
]
var i = 0

func start():
	i = 0
	texture = images[i]
	visible = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		if i >= 3:
			visible = false
		else:
			i += 1
			texture = images[i]
	
