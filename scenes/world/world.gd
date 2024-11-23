class_name World
extends Node2D

var areas: Array[Area]
var paths: Array[TravelPath]

func _ready():
	areas.assign($Areas.get_children())
	paths.assign($TravelPaths.get_children())
	#for area in areas:
		#for path in paths:
			#if path.starts_at == area or path.ends_at == area:
				#paths.append(path)
				

	
func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
