class_name Area
extends Node2D

var spots: Array[Spot]
var paths: Array[TravelPath]

@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	spots.assign($Spots.get_children())

func connects_to(path: TravelPath) -> int:
	var points: PackedVector2Array = path.curve.get_baked_points()
	var first = collision_shape.to_local(path.to_global(points[0]))
	var last = collision_shape.to_local(path.to_global(points[-1]))
	var rect = collision_shape.shape.get_rect()
	
	if rect.has_point(first):
		return -1
	elif rect.has_point(last):
		return 1
	else:
		return 0
	
