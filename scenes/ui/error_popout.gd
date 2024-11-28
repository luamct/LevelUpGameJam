class_name ErrorPopout
extends PanelContainer

@onready var label: Label = $MarginContainer/Label
@onready var auto_destroy_timer: Timer = $AutoDestroyTimer

func _ready():
	auto_destroy_timer.timeout.connect(on_auto_destroy)

func on_auto_destroy():
	queue_free()

func setup(text: String):
	label.text = text
	position = get_global_mouse_position() + Vector2(0, -50)
