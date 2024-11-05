class_name Game
extends Node2D

@onready var gold_label: Label = %GoldLabel

func _ready():
	# Get the current screen resolution
	var screen_size = DisplayServer.screen_get_size()
	var window_width = int(screen_size.x * 0.25)
	var window_height = screen_size.y  # 30% of screen height

	#print(screen_size)
	#print(DisplayServer.window_get_position())

	# Set the window size
	DisplayServer.window_set_size(Vector2i(window_width, window_height))

	# Position the window at the bottom of the screen
	DisplayServer.window_set_position(Vector2i(screen_size.x - window_width, 0))

	# Make sure the window is borderless
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	
	Globals.chest_clicked.connect(on_chest_clicked)

func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func on_chest_clicked():
	gold_label.text = str(Globals.current_gold)
	
