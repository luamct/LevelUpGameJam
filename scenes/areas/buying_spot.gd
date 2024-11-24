class_name BuyingSpot
extends Spot

@export var buy_cost: int = 10  # Cost to hire adventurers

# Function to add an adventurer to a slot
func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		print("Slot is already occupied!")
		return false

	# Try to remove this adventurer from current slot.
	if adventurer.spot:
		if not adventurer.spot.try_to_remove_adventurer(adventurer):
			return false
	
	try_to_hire_adventurer()
	adventurer.add_to_spot(self)
	adventurers[slot_number] = adventurer

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

func try_to_hire_adventurer() -> bool:
	# Check if the player has enough gold to hire
	if Globals.current_gold < buy_cost:
		print("Not enough gold to hire!")
		return false
	
	var has_free_slot = 3
	for adventurer in adventurers:
		var slot_number = adventurers.find(adventurer)
		print("Slot Number: " + str(slot_number))
		has_free_slot -= 1
		print("Free Slot Number: " + str(has_free_slot))
	if not has_free_slot:
		print("There is no free slot to hire a new adventure!")
		return false

	Globals.current_gold -= buy_cost
	Globals.gold_updated.emit(Globals.current_gold)
	return true
