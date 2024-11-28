class_name SpotInfoProduction
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var requirements_container: VBoxContainer = %RequirementsContainer
@onready var gold_output_value: Label = %GoldOutputValue
@onready var slots_container: HBoxContainer = %SlotsContainer

func setup(spot: Spot):
	name_label.text = spot.name
	
	# Show requirements, if any
	if spot.requirements.size() == 0:
		requirements_container.visible = false
	else:
		free_children(requirements_container)
		for requirement in spot.requirements:
			var label = Label.new()
			label.text = "  %d+ %s" % [requirement.minimum_value, Enums.attribute_string(requirement.attribute)]
			requirements_container.add_child(label)

	# Show gold output
	gold_output_value.text = "  +%d per adventurer" % [spot.gold_output]

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
