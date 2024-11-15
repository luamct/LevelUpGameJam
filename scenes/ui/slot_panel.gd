class_name SlotPanel
extends Panel

@onready var button: Button = $Button
@onready var portrait: Portrait = $Portrait

var number: int
var spot: Spot
var adventurer: Adventurer

func _ready() -> void:
	button.pressed.connect(on_panel_clicked)

func on_panel_clicked():
	if Globals.selected_adventurer:
		if adventurer:
			print("Slot is already busy!")
			return

		adventurer = Globals.selected_adventurer
		portrait.visible = true
		portrait.set_portrait_texture(adventurer.portrait)
		
		spot.add_adventurer(adventurer, number)
		
