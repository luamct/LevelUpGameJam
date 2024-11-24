class_name BuyingSpot
extends Spot

@export var buy_cost: int = 10  # Cost to hire adventurers

signal slot_updated  # Signal to notify the interface to update buttons

# Function to add an adventurer to a slot
func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		print("Slot is already occupied!")
		return false

	# Try to remove this adventurer from the current slot
	if adventurer.spot:
		if not adventurer.spot.try_to_remove_adventurer(adventurer):
			return false

	# Assign the adventurer to this spot without charging
	adventurer.spot = self
	adventurers[slot_number] = adventurer

	# Emit signal to notify that a slot was updated
	adventurer_added.emit(adventurer, slot_number)
	slot_updated.emit()  # Notify UI to update buttons
	print("Adventurer added to slot:", slot_number)

	return true

# Function to remove an adventurer from a slot
func try_to_remove_adventurer(adventurer: Adventurer) -> bool:
	var slot_number = adventurers.find(adventurer)
	if slot_number < 0:
		return false

	adventurers[slot_number] = null
	adventurer_removed.emit(adventurer, slot_number)
	slot_updated.emit()  # Notify UI to update buttons
	print("Adventurer removed from slot:", slot_number)
	return true

# Function to handle hiring a new adventurer
func try_to_hire_adventurer(slot_number: int) -> bool:
	# Check if there is a free slot
	var has_free_slot = adventurers.count(null) > 0
	if not has_free_slot:
		print("There are no free slots to hire a new adventurer!")
		return false

	# Check if the player has enough gold
	if Globals.current_gold < buy_cost:
		print("Not enough gold to hire!")
		return false

	# Deduct gold and create a new adventurer
	Globals.current_gold -= buy_cost
	Globals.gold_updated.emit(Globals.current_gold)

	var new_adventurer = Globals.create_adventurer()
	adventurers[slot_number] = new_adventurer
	new_adventurer.spot = self

	adventurer_added.emit(new_adventurer, slot_number)
	slot_updated.emit()  # Notify UI to update buttons
	print("New adventurer hired and added to slot:", slot_number)

	return true
