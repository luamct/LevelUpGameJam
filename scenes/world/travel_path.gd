class_name TravelPath
extends Path2D

@onready var line: Line2D = $Line2D

var starts_at: Area
var ends_at: Area
var dashed: bool = true

func _ready() -> void:
	line.set_antialiased(true)
	var points: PackedVector2Array = curve.get_baked_points()
	for point in points:
		line.add_point(point)
		
	var areas: Array[Node] = get_tree().get_nodes_in_group("area")
	for area in areas:
		
		var first = area.to_local(to_global(points[0]))
		var last = area.to_local(to_global(points[-1]))
		var rect = area.collision_shape.shape.get_rect()
		if rect.has_point(first):
			starts_at = area
			area.paths.append(self)
		elif rect.has_point(last):
			ends_at = area
			area.paths.append(self)
		
		if starts_at and ends_at:
			break

	assert(starts_at, "Could not find starting area for path " + self.name)
	assert(ends_at, "Could not find ending area for path " + self.name)
