class_name World
extends Node2D

func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
