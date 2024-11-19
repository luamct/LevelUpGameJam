class_name SpotInfoTraining
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var gold_price_value: Label = %GoldPriceValue
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var time_to_level: Label = %TimeToLevelValue

var training_timer: Timer

func _ready() -> void:
	pass

func setup(spot: Spot):
	name_label.text = spot.name

	gold_price_value.text = "  %d per xp" % [spot.gold_per_xp]
	time_to_level.text = str(spot.xp_per_second) + " xp per second"

	# Add slots
	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)

func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()
