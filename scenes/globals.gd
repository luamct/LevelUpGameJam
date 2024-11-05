extends Node

signal chest_clicked

@export var gold_per_click: int

var current_gold: int = 0

func _ready() -> void:
	chest_clicked.connect(on_chest_clicked)

func on_chest_clicked():
	current_gold += gold_per_click
