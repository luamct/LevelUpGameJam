class_name Spot
extends Node2D

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
