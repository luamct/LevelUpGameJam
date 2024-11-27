extends Node

signal gold_collected
signal gold_updated(gold: int)
signal update_bottom_panel(adventurer: Adventurer)
signal hired_adventurer(adventurer: Adventurer)

@export var km_per_pixel: float
@export var base_speed: float  # km per second
@export var speed_per_point: float  # + km per second per speed attribute

var xp_table: Array[int] = [
	0, 1050, 2450, 4550, 7700, 12425, 19513, 30145, 46094, 70018, 105904, 
	159732, 240474, 361587, 543257, 815762, 1224520, 1837656, 2757360, 4136916
]

var current_gold: int = 0
var selected_adventurer: Adventurer

func _ready() -> void:
	gold_collected.connect(on_gold_collected)

func on_gold_collected(gold: int):
	current_gold += gold
	gold_updated.emit(current_gold)

func adventurer_selected(adventurer: Adventurer):
	selected_adventurer = adventurer

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_EQUAL):
		current_gold += 100
		gold_updated.emit(current_gold)

func selected_adventurer_speed() -> float:
	return base_speed + selected_adventurer.speed * speed_per_point

func calculate_speed(adventurer: Adventurer) -> float:
	return base_speed + adventurer.speed * speed_per_point

func add_adventurer_to_firecamp(adventurer: Adventurer):
	print("Adventurer added to firecamp:", adventurer.name_)
