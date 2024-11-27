class_name BuyingSpot
extends Spot

@export var buy_cost: int = 10 

# Function to add an adventurer into a slot
func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	# Try to remove this adventurer from the current slot
	if adventurer.spot:
		if not adventurer.spot.try_to_remove_adventurer(adventurer):
			return false

	# Assign the adventurer to this spot without charging
	adventurer.spot = self
	adventurers[slot_number] = adventurer

	# Emit signal to notify that a slot was updated
	adventurer_added.emit(adventurer, slot_number)

	print("Adventurer added to slot:", slot_number)
	return true

# Function to remove an adventurer from a slot
func try_to_remove_adventurer(adventurer: Adventurer) -> bool:
	var slot_number = adventurers.find(adventurer)
	if slot_number < 0:
		return false

	adventurers[slot_number] = null
	adventurer_removed.emit(adventurer, slot_number)
	print("Adventurer removed from slot:", slot_number)
	return true

# Function to handle hiring a new adventurer
func try_to_hire_adventurer(slot_number: int) -> bool:
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

	return true
