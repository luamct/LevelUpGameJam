class_name SpotInfoFirecamp
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var slots_container: HBoxContainer = %SlotsContainer

func setup(spot: Spot):
	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)
