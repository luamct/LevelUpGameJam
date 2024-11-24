class_name ProductionSpot
extends Spot

@export var requirements: Array[Requirement]
@export var gold_output: int  # Gold per second per working adventurer

@onready var production_timer: Timer = $ProductionTimer

func _ready() -> void:
	super()
	production_timer.timeout.connect(on_tick)

func on_tick():
	var gold = 0
	for adventurer in adventurers:
		if adventurer:
			gold += gold_output * production_timer.wait_time

	Globals.gold_collected.emit(gold)

func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		print("Slot is already busy!")
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
	
