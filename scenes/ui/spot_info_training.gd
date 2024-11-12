class_name SpotInfo
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var gold_price_value: Label = %GoldPriceValue
@onready var slots_container: HBoxContainer = %SlotsContainer

func setup(spot: Spot):
	name_label.text = spot.name_
		
	# Show gold output
	gold_price_value.text = "  %d per level" % [spot.level_cost]

	# Add slots
	free_children(slots_container)
	for i in range(spot.slots):
		var slot = SLOT_PANEL_SCENE.instantiate()
		slots_container.add_child(slot)

func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()

func _ready() -> void:
	pass
