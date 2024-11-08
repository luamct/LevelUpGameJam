extends Node

signal plantation_clicked
signal gold_updated(gold: int)

@export var gold_per_click: int

var current_gold: int = 0

func _ready() -> void:
	plantation_clicked.connect(on_plantation_clicked)

func on_plantation_clicked():
	current_gold += gold_per_click
	gold_updated.emit(current_gold)
