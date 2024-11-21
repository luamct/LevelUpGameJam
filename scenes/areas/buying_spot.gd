class_name BuyingSpot
extends Spot

@export var buy_cost: int = 10  # Cost to hire adventurers

# Function to add an adventurer to a slot
func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		print("Slot is already occupied!")
		return false

	# Check if the player has enough gold to hire
	if Globals.current_gold < buy_cost:
		print("Not enough gold to hire!")
		return false

	Globals.current_gold -= buy_cost
	Globals.gold_updated.emit(Globals.current_gold)
	
	adventurer.spot = self
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
