class_name FirecampSpot
extends Spot

func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		Globals.show_error_popout.emit("Slot is already busy!", 1.5)
		return false

	# Try to remove this adventurer from current slot. Some spots, 
	# like training, don't allow removing the adventurer
	if adventurer.spot:
		if not adventurer.spot.try_to_remove_adventurer(adventurer):
			return false
	
	# Add to this spot
	adventurer.add_to_spot(self)
	adventurers[slot_number] = adventurer
	
	adventurer_added.emit(adventurer, slot_number)
	return true

func try_to_remove_adventurer(adventurer: Adventurer) -> bool:
	var slot_number = adventurers.find(adventurer)
	if slot_number < 0:
		return false
		
	adventurers[slot_number] = null
	adventurer_removed.emit(adventurer, slot_number)
	return true
	
