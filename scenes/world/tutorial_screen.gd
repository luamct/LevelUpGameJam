extends TextureRect

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		visible = false
