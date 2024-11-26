class_name SpotInfoBuying
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var hiring_cost = %HiringCost
@onready var predefined_list_container: VBoxContainer = %PredefinedListContainer 
@onready var adventurer_slots = %AdventurerSlots

var current_spot: Spot  # Store the current spot reference

func setup(spot: Spot):
	name_label.text = spot.name
	hiring_cost.text = str(spot.buy_cost) + " Gold per Adventurer"

	spot.predefined_adventurers_available.connect(func(adventurers: Array): show_predefined_adventurers(adventurers))

	var slot_adventurer: SlotPanel = SLOT_PANEL_SCENE.instantiate()
	slot_adventurer.number = 1
	slot_adventurer.spot = spot
	slots_container.add_child(slot_adventurer)
	
	#var slot_hiring: SlotPanel = SLOT_PANEL_SCENE.instantiate()
	#slot_hiring.number = 3
	#slot_hiring.spot = spot
	#adventurer_slots.add_child(slot_hiring)
	
	if spot is BuyingSpot:
		spot.init_predefined_adventurers()
		show_predefined_adventurers(spot.predefined_adventurers)


func hire_adventurer(spot: Spot, slot_number: int):
	if not spot.get_adventurer_in_slot(slot_number):
		if spot.try_to_hire_adventurer(slot_number):
			print("Adventurer successfully hired!")
		else:
			print("Failed to hire adventurer.")
	else:
		print("Slot is already occupied! Cannot hire.")


func show_predefined_adventurers(adventurers: Array):
	print("Lista de aventureiros a serrem contratados")
	#predefined_list_container.clear() 
	for adventurer in adventurers:
		print(str(adventurer))
		var button = Button.new()
		button.text = adventurer.name_ + " - Hire"
		button.pressed.connect(func(): hire_predefined_adventurer(adventurer))
		predefined_list_container.add_child(button)


func hire_predefined_adventurer(adventurer: Adventurer):
	if Globals.current_gold >= current_spot.buy_cost:
		if current_spot.hire_predefined_adventurer(adventurer):
			
			for child in predefined_list_container.get_children():
				if child.text.startswith(adventurer.name_):
					child.queue_free()
			print("Predefined adventurer hired:", adventurer.name_)
		else:
			print("Failed to hire predefined adventurer:", adventurer.name_)
	else:
		print("Not enough gold to hire the predefined adventurer.")


func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()
