extends Node

signal spot_clicked
signal gold_updated(gold: int)

@export var gold_per_click: int

var current_gold: int = 0

func _ready() -> void:
	spot_clicked.connect(on_spot_clicked)

func on_spot_clicked():
	current_gold += gold_per_click
	gold_updated.emit(current_gold)
