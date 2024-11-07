class_name Chest
extends Node2D

@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.input_event.connect(on_click)
	
func on_click(_viewport, event, _shape_idx):
	if event.is_action_pressed("click"):
		Globals.plantation_clicked.emit()
