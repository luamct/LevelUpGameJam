extends Node

signal gold_collected
signal gold_updated(gold: int)

@export var gold_per_click: int

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

func create_adventurer():
	var adventurer_scene = preload("res://scenes/adventurer/adventurer.tscn")
	return adventurer_scene.instantiate()

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_EQUAL):
		current_gold += 100
		gold_updated.emit(current_gold)
