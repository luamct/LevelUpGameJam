class_name SlotPanel
extends Panel

@onready var button: Button = $Button
@onready var portrait: Portrait = $Portrait

var number: int
var spot: Spot
#var adventurer: Adventurer

func _ready() -> void:
	button.pressed.connect(on_panel_clicked)
	spot.adventurer_removed.connect(on_adventurer_removed)

func on_adventurer_removed(_adventurer: Adventurer, slot_number: int):
	if slot_number == number:
		portrait.visible = false
	
func on_panel_clicked():
	if Globals.selected_adventurer:
		var success = spot.try_to_add_adventurer(Globals.selected_adventurer, number)
		
		# Set portrait to this panel if successful
		if success:
			portrait.visible = true
			portrait.set_portrait_texture(Globals.selected_adventurer.portrait)
