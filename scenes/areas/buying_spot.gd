class_name BuyingSpot
extends Spot

@export var buy_cost: int = 10 

var predefined_adventurers: Array = []

signal predefined_adventurers_available(predefined_adventurers: Array)
signal slot_updated 

func init_predefined_adventurers():
	predefined_adventurers = [
		Globals.create_adventurer("Bard"),
		Globals.create_adventurer("Paladin"),
		Globals.create_adventurer("Rogue")
	]

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

	# When the initial adventurer is added, make predefined adventurers available
	if len(predefined_adventurers) > 0:
		emit_signal("predefined_adventurers_available", predefined_adventurers)

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

# Function to hire one of the predefined adventurers
func hire_predefined_adventurer(adventurer: Adventurer) -> bool:
	# Check if there is enough gold
	if Globals.current_gold < buy_cost:
		print("Not enough gold to hire the predefined adventurer!")
		return false

	# Deduct gold and add the adventurer to the firecamp (to be implemented)
	Globals.current_gold -= buy_cost
	Globals.gold_updated.emit(Globals.current_gold)

	# Emit signal to notify the UI that predefined adventurers have been updated
	predefined_adventurers.erase(adventurer)
	emit_signal("predefined_adventurers_available", predefined_adventurers)

	print("Predefined adventurer hired:", adventurer.name_)
	return true
