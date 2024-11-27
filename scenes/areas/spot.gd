class_name Spot
extends Node2D

signal adventurer_added(adventurer: Adventurer, slot_number: int)
signal adventurer_removed(adventurer: Adventurer, slot_number: int)

# Number of available slots
@export var slots: int

# Always has "slots" items, one for each slot on this spot. A non-null 
# value at index i means an adventurer is working on that slot
@export var adventurers: Array[Adventurer]

@onready var area: Area = $"../.."

func _ready() -> void:
	for i in slots:
		adventurers.append(null)

func try_to_add_adventurer(_adventurer: Adventurer, _slot_number: int) -> bool:
	assert(false, "Method not implemented on subclass")
	return false

func try_to_remove_adventurer(_adventurer: Adventurer) -> bool:
	assert(false, "Method not implemented on subclass")
	return false
	
# Unique name including area name
func full_name() -> String:
	return "%s_%s" % [area.name, name]
	
