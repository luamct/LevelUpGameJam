class_name Popouts
extends Control

const ERROR_POPOUT = preload("res://scenes/ui/error_popout.tscn")
@onready var story_popout: StoryPopout = $StoryPopout

func _ready():
	Globals.show_error_popout.connect(on_show_error_popout)
	Globals.show_story_popout.connect(on_show_story_popout)
	
func on_show_error_popout(text: String, seconds: float):
	var popout = ERROR_POPOUT.instantiate()
	add_child(popout)
	popout.setup(text, seconds)
	
func on_show_story_popout(area: String, text: String):
	story_popout.show_popout(area, text)
