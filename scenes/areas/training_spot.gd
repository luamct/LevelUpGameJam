class_name TrainingSpot
extends Spot

@export var max_level: int = 20 # Can't only train adventurers below this level
@export var gold_per_xp: int # How much it costs to level up an adventurer (in gold)
@export var xp_per_second: int # How long does it take to level up one adventurer (in seconds)

@onready var training_timer: Timer = $TrainingTimer

func _ready():
	super()
	training_timer.timeout.connect(on_training_tick)
	
func try_to_add_adventurer(adventurer: Adventurer, slot_number: int) -> bool:
	if adventurers[slot_number]:
		Globals.show_error_popout.emit("Slot is already busy!", 1.5)
		return false
	
	# Try to remove this adventurer from current slot. Some spots, 
	# like training, don't allow removing the adventurer
	if adventurer.spot:
		adventurer.spot.try_to_remove_adventurer(adventurer)

	# Add to this spot
	adventurer.add_to_spot(self)
	adventurers[slot_number] = adventurer
	
	adventurer_added.emit(adventurer, slot_number)
	
	Globals.update_side_panel.emit()
	return true

func on_training_tick():
	for adventurer in adventurers:
		if not adventurer:
			continue
	
		if adventurer.total_level() >= max_level:
			if !Globals.error_cap:
				Globals.show_error_popout.emit("Cannot train %s beyond level %d" % [adventurer.name_, max_level], 4)
				Globals.error_cap = true
			continue
	
		if Globals.current_gold < gold_per_xp:
			if !Globals.error_cap:
				Globals.show_error_popout.emit("Not enough gold for training!", 3)
				Globals.error_cap = true
			continue

		Globals.current_gold -= gold_per_xp
		Globals.gold_updated.emit(Globals.current_gold)

		adventurer.add_xp(xp_per_second)
		
		Globals.error_cap = false

func try_to_remove_adventurer(adventurer: Adventurer) -> bool:
	var slot_number = adventurers.find(adventurer)
	if slot_number < 0:
		return false
		
	adventurers[slot_number] = null
	adventurer_removed.emit(adventurer, slot_number)
	Globals.update_side_panel.emit()
	Globals.error_cap = false
	return true
	
