class_name TrainingSpot
extends Spot

@export var level_cost: int # How much it costs to level up an adventurer (in gold)
@export var level_time: int # How long does it take to level up one adventurer (in seconds)

func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		print("Slot is already busy!") # TODO: Pop out
		return false

	if Globals.current_gold < level_cost:
		print("Not enough gold!")  # TODO: Pop out
		return false

	Globals.current_gold -= level_cost
	Globals.gold_updated.emit(Globals.current_gold)
	
	# Try to remove this adventurer from current slot. Some spots, 
	# like training, don't allow removing the adventurer
	if adventurer.spot:
		if not adventurer.spot.try_to_remove_adventurer(adventurer):
			return false

	# Add to this spot
	adventurer.spot = self
	adventurers[slot_number] = adventurer
	
	adventurer_added.emit(adventurer, slot_number)
	return true

# If this adventurer is in fact in this spot, it cannot be removed 
# until training is over. Otherwise, we return true to signify success
func try_to_remove_adventurer(adventurer: Adventurer) -> bool:
	var slot_number = adventurers.find(adventurer)
	
	if slot_number >= 0:
		print("Adventurer is training and cannot be moved yet!")
		return false
	else:
		return true
