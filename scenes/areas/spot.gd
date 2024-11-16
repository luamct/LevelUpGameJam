class_name Spot
extends Node2D

signal adventurer_added(adventurer: Adventurer, slot_number: int)
signal adventurer_removed(adventurer: Adventurer, slot_number: int)

@export var name_: String
@export var slots: int     # Number of available slots

# Always has "slots" items, one for each slot on this spot. 
# A non-null value at index i means an adventurer is working 
# on that slot
@export var adventurers: Array[Adventurer]

func _ready() -> void:
	for i in slots:
		adventurers.append(null)

func add_adventurer(adventurer: Adventurer, slot_number: int) -> void:
	adventurers[slot_number] = adventurer
	adventurer_added.emit(adventurer, slot_number)

func remove_adventurer(adventurer: Adventurer):
	var slot_number = adventurers.find(adventurer)
	if slot_number >= 0:
		adventurers[slot_number] = null
		adventurer_removed.emit(adventurer, slot_number)
	
