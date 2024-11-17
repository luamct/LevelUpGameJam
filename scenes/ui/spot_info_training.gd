class_name SpotInfoTraining
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var gold_price_value: Label = %GoldPriceValue
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var time_to_level: Label = %TimeToLevelValue

func setup(spot: Spot):
	name_label.text = spot.name

	# Show gold output
	gold_price_value.text = "  %d per level" % [spot.level_cost]

	# Show time to level
	time_to_level.text = str(spot.level_time) + " seconds"
	
	# Add slots
	free_children(slots_container)
	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)

func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()

func _ready() -> void:
	pass
