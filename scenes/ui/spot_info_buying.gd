class_name SpotInfoBuying
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var hiring_cost = %HiringCost

var are_buttons_visible: bool = false  # State to control button visibility

# Setup function to initialize the buying spot UI
func setup(spot: Spot):
	name_label.text = spot.name
	hiring_cost.text = str(spot.buy_cost) + " Gold per Adventurer"

	# Connect the spot's signal to update buttons
	spot.slot_updated.connect(func(): update_buttons(spot))

	# Clear existing slots and populate with current slots
	free_children(slots_container)
	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)

		# Add Hire button only if the slot is empty
		if not spot.get_adventurer_in_slot(i):
			var button = Button.new()
			button.name = "HireButton_%d" % i  # Unique name for tracking
			button.text = "Hire!"
			button.visible = false  # Initially hidden
			button.pressed.connect(func(): hire_adventurer(spot, i))
			slots_container.add_child(button)

# Function to handle hiring an adventurer
func hire_adventurer(spot: Spot, slot_number: int):
	if not spot.get_adventurer_in_slot(slot_number):
		if spot.try_to_hire_adventurer(slot_number):
			print("Adventurer successfully hired!")
		else:
			print("Failed to hire adventurer.")
	else:
		print("Slot is already occupied! Cannot hire.")

# Function to refresh buttons based on slot occupation
func update_buttons(spot: Spot):
	var initial_occupied_slot = false  # Check if the initial adventurer is in a slot

	for i in range(spot.slots):
		var button = slots_container.get_node_or_null("HireButton_%d" % i)
		
		if spot.get_adventurer_in_slot(i):
			# If the slot is occupied by the initial adventurer, mark it
			if not are_buttons_visible:
				initial_occupied_slot = true
			
			# Remove the button if the slot is now occupied
			if button:
				button.queue_free()
		else:
			# Add the button back if the slot is empty and no button exists
			if not button:
				var new_button = Button.new()
				new_button.name = "HireButton_%d" % i
				new_button.text = "Hire!"
				new_button.visible = are_buttons_visible  # Show only if conditions are met
				new_button.pressed.connect(func(): hire_adventurer(spot, i))
				slots_container.add_child(new_button)

	# Show all buttons if the initial adventurer occupies a slot
	if initial_occupied_slot:
		show_buttons()

# Function to show all hire buttons
func show_buttons():
	are_buttons_visible = true
	for child in slots_container.get_children():
		if child is Button and child.name.begins_with("HireButton_"):
			child.visible = true

# Utility function to free existing children
func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()
