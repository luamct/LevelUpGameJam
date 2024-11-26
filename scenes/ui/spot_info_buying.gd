class_name SpotInfoBuying
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")
const AVAILABLE_ADVENTURER_SCENE = preload("res://scenes/ui/available_adventurer.tscn")

@onready var name_label: Label = %NameLabel
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var predefined_list_container: VBoxContainer = %PredefinedListContainer 
@onready var adventurer_slots = %AdventurerSlots


func setup(spot: Spot):
	name_label.text = spot.name

	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)
	
	if spot is BuyingSpot:
		var adventurers = spot.get_children().filter(func(adv):return adv is Adventurer)
		for adventurer in adventurers:
			var slot: AvailableAdventurer = AVAILABLE_ADVENTURER_SCENE.instantiate()
			adventurer_slots.add_child(slot)
			slot.setup(adventurer)
			slot.button.pressed.connect(func(): on_portrait_clicked(adventurer))

func on_portrait_clicked(adventurer: Adventurer):
	print("Aventureiro clicado")

func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()
