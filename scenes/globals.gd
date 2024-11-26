extends Node

signal gold_collected
signal gold_updated(gold: int)
signal update_bottom_panel(adventurer: Adventurer)

@export var km_per_pixel: float
@export var base_speed: float  # km per second
@export var speed_per_point: float  # + km per second per speed attribute

var xp_table: Array[int] = [
	0, 1050, 2450, 4550, 7700, 12425, 19513, 30145, 46094, 70018, 105904, 
	159732, 240474, 361587, 543257, 815762, 1224520, 1837656, 2757360, 4136916
]

var current_gold: int = 0
var selected_adventurer: Adventurer
var predefined_adventurers: Array = []

func _ready() -> void:
	gold_collected.connect(on_gold_collected)

func on_gold_collected(gold: int):
	current_gold += gold
	gold_updated.emit(current_gold)

func adventurer_selected(adventurer: Adventurer):
	selected_adventurer = adventurer

func create_adventurer(adventurer_type: String = "") -> Adventurer:
	var adventurer_scene = preload("res://scenes/adventurer/adventurer.tscn")
	var adventurer = adventurer_scene.instantiate()
	
	match adventurer_type:
		"Bard":
			adventurer.name_ = "Bard"
			adventurer.portrait = preload("res://assets/classes/bard_1.png")
			adventurer.strength = 5
			adventurer.speed = 6
			adventurer.agility = 7
			adventurer.defense = 4
			adventurer.attack = 3
			adventurer.morale = 8
			adventurer.discipline = 6
			adventurer.hire_cost = 6000
		"Paladin":
			adventurer.name_ = "Paladin"
			adventurer.portrait = preload("res://assets/classes/paladin_1.png")
			adventurer.strength = 8
			adventurer.speed = 4
			adventurer.agility = 5
			adventurer.defense = 7
			adventurer.attack = 4
			adventurer.morale = 9
			adventurer.discipline = 7
		"Rogue":
			adventurer.name_ = "Rogue"
			adventurer.portrait = preload("res://assets/classes/rogue_1.png")
			adventurer.strength = 6
			adventurer.speed = 9
			adventurer.agility = 8
			adventurer.defense = 3
			adventurer.attack = 5
			adventurer.morale = 7
			adventurer.discipline = 5
		_:
			adventurer.name_ = "Adventurer"
			adventurer.portrait = preload("res://assets/classes/fighter_1.png")
			adventurer.strength = 5
			adventurer.speed = 5
			adventurer.agility = 5
			adventurer.defense = 5
			adventurer.attack = 5
			adventurer.morale = 5
			adventurer.discipline = 5
	return adventurer

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
