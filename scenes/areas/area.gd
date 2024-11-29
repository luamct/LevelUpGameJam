class_name Area
extends Node2D

var spots: Array[Spot]
var paths: Array[TravelPath]
var already_visited: bool = false

@export_multiline var story_text: String

@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

@export_multiline var story_text: String

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

# Once an area is visited, all connected paths and areas are revealed
# Calling this method on an already visited area has no effect
func visited():
	# If arriving for the first time, show the story/tutorial popout
	if !already_visited:
		already_visited = true
		if story_text:
			Globals.show_story_popout.emit(name, story_text)
		
	for path in paths:
		path.visible = true
		path.starts_at.visible = true
		path.ends_at.visible = true
