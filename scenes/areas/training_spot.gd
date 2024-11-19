class_name TrainingSpot
extends Spot

@export var gold_per_xp: int # How much it costs to level up an adventurer (in gold)
@export var xp_per_second: int # How long does it take to level up one adventurer (in seconds)

@onready var training_timer: Timer = $TrainingTimer

func _ready():
	super()
	training_timer.timeout.connect(on_training_tick)
	
func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		print("Slot is already busy!") # TODO: Pop out
		return false
	
	# Try to remove this adventurer from current slot. Some spots, 
	# like training, don't allow removing the adventurer
	if adventurer.spot:
		adventurer.spot.try_to_remove_adventurer(adventurer)

	# Add to this spot
	adventurer.spot = self
	adventurers[slot_number] = adventurer
	
	adventurer_added.emit(adventurer, slot_number)
	return true

func on_training_tick():
	for adventurer in adventurers:
		if adventurer:
			if Globals.current_gold < gold_per_xp:
				print("Not enough gold for training!")  # TODO: Pop out
				continue

			Globals.current_gold -= gold_per_xp
			Globals.gold_updated.emit(Globals.current_gold)

			adventurer.add_xp(xp_per_second)

func try_to_remove_adventurer(adventurer: Adventurer) -> bool:
	var slot_number = adventurers.find(adventurer)
	if slot_number < 0:
		return false
		
	adventurers[slot_number] = null
	adventurer_removed.emit(adventurer, slot_number)
	return true
	
