class_name SpotInfoBuying
extends HBoxContainer

const SLOT_PANEL_SCENE = preload("res://scenes/ui/slot_panel.tscn")
const AVAILABLE_ADVENTURER_SCENE = preload("res://scenes/ui/available_adventurer.tscn")

@onready var name_label: Label = %NameLabel
@onready var slots_container: HBoxContainer = %SlotsContainer
@onready var predefined_list_container: VBoxContainer = %PredefinedListContainer 
@onready var adventurer_slots = %AdventurerSlots
@onready var level_value = $InfoAdventurer/GridContainer/LevelContainer/Value
@onready var strength_value = $InfoAdventurer/GridContainer/StrengthContainer/Value
@onready var speed_value = $InfoAdventurer/GridContainer/SpeedContainer/Value
@onready var agility_value = $InfoAdventurer/GridContainer/AgilityContainer/Value
@onready var defense_value = $InfoAdventurer/GridContainer/DefenseContainer/Value
@onready var attack_value = $InfoAdventurer/GridContainer/AttackContainer/Value
@onready var morale_value = $InfoAdventurer/GridContainer/MoraleContainer/Value
@onready var discipline_value = $InfoAdventurer/GridContainer/DisciplineContainer/Value
@onready var status_label = $InfoAdventurer/HBoxContainer/Label
@onready var hire_cost = $InfoAdventurer/HBoxContainer/HireCost
@onready var info_adventurer = $InfoAdventurer


func setup(spot: Spot):
	name_label.text = spot.name
	predefined_list_container.visible = false
	info_adventurer.visible = false

	for i in range(spot.slots):
		var slot: SlotPanel = SLOT_PANEL_SCENE.instantiate()
		slot.number = i
		slot.spot = spot
		slots_container.add_child(slot)
	
	if spot is BuyingSpot:
		spot.connect("adventurer_added", Callable(self, "_on_adventurer_added"))
		spot.connect("adventurer_removed", Callable(self, "_on_adventurer_removed"))
		
		var adventurers = spot.get_children().filter(func(adv):return adv is Adventurer)
		for adventurer in adventurers:
			var slot: AvailableAdventurer = AVAILABLE_ADVENTURER_SCENE.instantiate()
			adventurer_slots.add_child(slot)
			slot.setup(adventurer)
			slot.button.pressed.connect(func(): on_portrait_clicked(adventurer))
			slot.hire_button.pressed.connect(func(): on_hire_button_pressed(adventurer, slot))

func _on_adventurer_added(adventurer: Adventurer, slot_number:int):
	predefined_list_container.visible = true
	
func _on_adventurer_removed(adventurer: Adventurer, slot_number:int):
	predefined_list_container.visible = false
	info_adventurer.visible = false

func on_portrait_clicked(adventurer: Adventurer):
	# Show status info container
	info_adventurer.visible = true
	
	# Fill the adventurer status
	status_label.text = adventurer.name + " Status -"
	hire_cost.text = "Cost: " + str(adventurer.hire_cost) 
	level_value.text = str(adventurer.level)
	strength_value.text = str(adventurer.strength)
	speed_value.text = str(adventurer.speed)
	agility_value.text = str(adventurer.agility)
	defense_value.text = str(adventurer.defense)
	attack_value.text = str(adventurer.attack)
	morale_value.text = str(adventurer.morale)
	discipline_value.text = str(adventurer.discipline)
	
func on_hire_button_pressed(adventurer: Adventurer, slot: AvailableAdventurer):
	on_portrait_clicked(adventurer)
	if Globals.current_gold < adventurer.hire_cost:
		print("Não há dinheiro suficiente para contratação do " + adventurer.name_)
		return
	
	Globals.current_gold -= adventurer.hire_cost
	Globals.gold_updated.emit(Globals.current_gold)
	Globals.add_adventurer_to_firecamp(adventurer)
	Globals.hired_adventurer.emit(adventurer)
	#print("Aventureiro contratado: " + adventurer.name_)
	
	# Remove hired adventurer from list to hire
	adventurer_slots.remove_child(slot)
	
	# Remove info status container
	info_adventurer.visible = false

func free_children(node: Control):
	for child in node.get_children():
		child.queue_free()
		
