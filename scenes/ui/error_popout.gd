class_name ErrorPopout
extends PanelContainer

@onready var label: Label = $MarginContainer/Label
@onready var auto_destroy_timer: Timer = $AutoDestroyTimer

func on_auto_destroy():
	queue_free()

func setup(text: String, seconds: float):
	label.text = text
	position = get_global_mouse_position() + Vector2(0, -50)
	auto_destroy_timer.wait_time = seconds
	auto_destroy_timer.timeout.connect(on_auto_destroy)
	auto_destroy_timer.start()
