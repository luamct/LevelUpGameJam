class_name Area
extends Node2D

var spots: Array[Spot]

func _ready() -> void:
	spots.assign($Spots.get_children())
