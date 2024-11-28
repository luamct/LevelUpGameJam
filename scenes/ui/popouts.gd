class_name Popouts
extends Control

const ERROR_POPOUT = preload("res://scenes/ui/error_popout.tscn")

func _ready():
	Globals.show_error_popout.connect(on_show_error_popout)
	
func on_show_error_popout(text: String):
	var popout = ERROR_POPOUT.instantiate()
	add_child(popout)
	popout.setup(text)
	
