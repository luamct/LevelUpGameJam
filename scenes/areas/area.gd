class_name Area
extends Node2D

var spots: Array[Spot]
var paths: Array[TravelPath]

func _ready() -> void:
	spots.assign($Spots.get_children())
