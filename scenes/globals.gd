extends Node

signal gold_collected
signal gold_updated(gold: int)

@export var gold_per_click: int

var current_gold: int = 0
var selected_adventurer: Adventurer

func _ready() -> void:
	gold_collected.connect(on_gold_collected)

func on_gold_collected(gold: int):
	current_gold += gold
	gold_updated.emit(current_gold)

func adventurer_selected(adventurer: Adventurer):
	selected_adventurer = adventurer
