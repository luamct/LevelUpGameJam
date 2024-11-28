class_name BottomPanel
extends MarginContainer

const SPOT_INFO_PRODUCTION = preload("res://scenes/ui/spot_info_production.tscn")
const SPOT_INFO_TRAINING = preload("res://scenes/ui/spot_info_training.tscn")
const SPOT_INFO_BUYING = preload("res://scenes/ui/spot_info_buying.tscn")
const SPOT_INFO_FIRECAMP = preload("res://scenes/ui/spot_info_firecamp.tscn")
const TRAVEL_INFO_PANEL = preload("res://scenes/ui/travel_info_panel.tscn")

@onready var spot_container: HBoxContainer = $SpotContainer
@onready var buttons_container: VBoxContainer = $SpotContainer/ButtonsContainer

var currently_showing_panel: Control = null

func _ready() -> void:
	Globals.update_bottom_panel.connect(update_buttons)

func update_buttons(adventurer: Adventurer):
	if currently_showing_panel:
		currently_showing_panel.visible = false
		currently_showing_panel = null
	buttons_container.visible = true
	
	for child in buttons_container.get_children():
		if child is Button:
			child.queue_free()

	if adventurer.area:
		for spot in adventurer.area.spots:
			var button: Button = Button.new()
			button.text = spot.name
			button.pressed.connect(func(): on_spot_button_pressed(spot))
			buttons_container.add_child(button)
		
		# There's always the option to travel if in an area
		var button: Button = Button.new()
		button.text = "Travel"
		button.pressed.connect(func (): on_travel_button_pressed(adventurer))
		buttons_container.add_child(button)

func on_travel_button_pressed(adventurer: Adventurer):
	var area_or_path_name: String
	if adventurer.area:
		area_or_path_name = adventurer.area.name
	else:
		area_or_path_name = adventurer.area.traveling_in.name

	var panel_name: String = "%s__TravelInfo" % [area_or_path_name]
	var panel_node = spot_container.get_node_or_null(panel_name)
	if currently_showing_panel:
		currently_showing_panel.visible = false
		
	if panel_node:
		panel_node.visible = true
		currently_showing_panel = panel_node
	else:
		var travel_info: TravelInfoPanel = TRAVEL_INFO_PANEL.instantiate()
		spot_container.add_child(travel_info)
		travel_info.name = panel_name
		travel_info.setup(adventurer)
		
		currently_showing_panel = travel_info
	
func get_spot_scene(spot: Spot) -> PackedScene:
	if spot is ProductionSpot: return SPOT_INFO_PRODUCTION
	elif spot is TrainingSpot: return SPOT_INFO_TRAINING
	elif spot is BuyingSpot: return SPOT_INFO_BUYING
	elif spot is FirecampSpot: return SPOT_INFO_FIRECAMP
	else: return null
	
func on_spot_button_pressed(spot: Spot):
	var panel_name: String = "%s__SpotInfo" % [spot.full_name()]
	var panel_node = spot_container.get_node_or_null(panel_name)
	if currently_showing_panel:
		currently_showing_panel.visible = false

	if panel_node:
		panel_node.visible = true
		currently_showing_panel = panel_node
	else:
		var spot_info_panel = get_spot_scene(spot).instantiate()
		spot_container.add_child(spot_info_panel)
		spot_info_panel.name = panel_name
		spot_info_panel.setup(spot)
			
		currently_showing_panel = spot_info_panel
