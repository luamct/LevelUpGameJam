class_name SpotInfoBuying
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var hiring_cost = %HiringCost

# Setup function to initialize the buying spot UI
func setup(spot: Spot):
	name_label.text = spot.name
	hiring_cost.text = str(spot.buy_cost) + " Gold per Adventurer"

	# Clear existing slots and populate with current slots
	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)

	# Add Hire buttons for available slots
	for i in range(spot.slots):
		if not spot.get_adventurer_in_slot(i):
			var button = Button.new()
			button.text = "Hire Adventurer"
			button.pressed.connect(func(): hire_adventurer(spot, i))
			slots_container.add_child(button)

# Function to handle hiring an adventurer
func hire_adventurer(spot: Spot, slot_number: int):
	if Globals.current_gold >= spot.buy_cost:
		Globals.current_gold -= spot.buy_cost
		Globals.gold_updated.emit(Globals.current_gold)

		var new_adventurer = Globals.create_adventurer()
		var success = spot.try_to_add_adventurer(new_adventurer, slot_number)
		if success:
			print("Adventurer hired and added to slot:", slot_number)
		else:
			print("Failed to hire adventurer.")
	else:
		print("Not enough gold to hire!")

# Utility function to free existing children
func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()
