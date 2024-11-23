class_name TravelPath
extends Path2D

@onready var line: Line2D = $Line2D

var dashed: bool = true

func _ready() -> void:
	line.set_antialiased(true)
	for point in curve.get_baked_points():
		line.add_point(point)
