class_name StoryPopout
extends PanelContainer

@onready var area_name_label: Label = %AreaNameLabel
@onready var area_text_label: Label = %AreaTextLabel

func _ready():
	set_process_input(false)
	
func show_popout(area_name: String, story_text: String):
	visible = true
	area_name_label.text = area_name
	area_text_label.text = story_text
	set_process_input(true)
	
func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("left_click"):
		visible = false
		set_process_input(false)

func show_again():
	visible = true
	set_process_input(true)
