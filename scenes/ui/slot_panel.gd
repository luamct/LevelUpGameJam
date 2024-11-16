class_name SlotPanel
extends Panel

@onready var button: Button = $Button
@onready var portrait: Portrait = $Portrait

var number: int
var spot: Spot
var adventurer: Adventurer

func _ready() -> void:
	button.pressed.connect(on_panel_clicked)
	spot.adventurer_removed.connect(on_adventurer_removed)

func on_adventurer_removed(_adv: Adventurer, slot_number: int):
	if slot_number == number:
		adventurer = null
		portrait.visible = false
	
func on_panel_clicked():
	if Globals.selected_adventurer:
		if adventurer:
			print("Slot is already busy!")
			return

		adventurer = Globals.selected_adventurer

		# Remove this adventurer from previous slot, if any
		if adventurer.spot:
			adventurer.spot.remove_adventurer(adventurer)
		
		# Add to this slot
		adventurer.spot = spot
		spot.add_adventurer(Globals.selected_adventurer, number)
		
		# To portrait to this panel
		portrait.visible = true
		portrait.set_portrait_texture(adventurer.portrait)
