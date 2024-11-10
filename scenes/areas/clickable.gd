class_name Clickable
extends Area2D

func _ready() -> void:
	input_event.connect(on_click)

func on_click(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		Globals.spot_clicked.emit()
