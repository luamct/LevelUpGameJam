class_name SpotInfoBuying
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")

@onready var name_label: Label = %NameLabel
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var hiring_cost = %HiringCost

func _ready() -> void:
	pass

func setup(spot: Spot):
	name_label.text = spot.name
	hiring_cost.text = str(spot.buy_cost) + " Gold per Adventurer"

	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)
	
	# Limpar slots e adicionar novos
	# free_children(slots_container)
	# for i in range(spot.slots):
	# 	var button = Button.new()
	# 	button.text = "Hire Adventurer"
	# 	button.pressed.connect(func(): hire_adventurer(spot))
	# 	slots_container.add_child(button)

func hire_adventurer(spot: Spot):
	if Globals.current_gold >= spot.buy_cost:
		Globals.current_gold -= spot.buy_cost
		Globals.gold_updated.emit(Globals.current_gold)
		
		var new_adventurer = Globals.create_adventurer()  # Assume uma função que cria novos aventureiros

		# Encontre o próximo slot disponível (índice)
		var available_slot = -1
		for i in range(spot.slots):
			if not spot.get_adventurer_in_slot(i):
				available_slot = i
				break

		if available_slot == -1:
			print("No available slots!")
			return

		spot.add_adventurer(new_adventurer, available_slot)
		print("Adventurer hired and placed in slot:", available_slot)
	else:
		print("Not enough gold!")


func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()
