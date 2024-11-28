class_name BuyingSpot
extends Spot

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

	#print("Adventurer added to slot:", slot_number)
	return true

# Function to remove an adventurer from a slot
func try_to_remove_adventurer(adventurer: Adventurer) -> bool:
	var slot_number = adventurers.find(adventurer)
	if slot_number < 0:
		return false

	adventurers[slot_number] = null
	adventurer_removed.emit(adventurer, slot_number)
	#print("Adventurer removed from slot:", slot_number)
	return true
