extends Node

signal plantation_clicked

@export var gold_per_click: int

var current_gold: int = 0

func _ready() -> void:
	plantation_clicked.connect(on_plantation_clicked)

func on_plantation_clicked():
	current_gold += gold_per_click
	print(current_gold)
