class_name BottomPanel
extends MarginContainer

const SPOT_INFO_PRODUCTION = preload("res://scenes/ui/spot_info_production.tscn")
const SPOT_INFO_TRAINING = preload("res://scenes/ui/spot_info_training.tscn")
const SPOT_INFO_BUYING = preload("res://scenes/ui/spot_info_buying.tscn")

@onready var spot_container: HBoxContainer = $SpotContainer
@onready var buttons_container: VBoxContainer = $SpotContainer/ButtonsContainer

var currently_showing_panel: Control = null

func _ready() -> void:
	pass

func show_buttons(adventurer: Adventurer):
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
		
		# There's always the option to travel
		var button: Button = Button.new()
		button.text = "Travel"
		button.pressed.connect(func (): on_travel_button_pressed(adventurer.area))
		buttons_container.add_child(button)
		
func on_travel_button_pressed(from: Area):
	var panel_name: String = "%s__TravelInfo" % [from.name]
	var panel_node = spot_container.get_node_or_null(panel_name)
	if currently_showing_panel:
		currently_showing_panel.visible = false
		
	if panel_node:
		panel_node.visible = true
		currently_showing_panel = panel_node
	else:
		var vbox = VBoxContainer.new()
		for path in from.paths:
			var button: Button = Button.new()
			if path.starts_at == from:
				button.text = path.ends_at.name
			else:
				button.text = path.starts_at.name
			vbox.add_child(button)
		
		spot_container.add_child(vbox)
		vbox.name = panel_name
		currently_showing_panel = vbox
		
	
func on_spot_button_pressed(spot: Spot):
	var panel_name: String = "%s__SpotInfo" % [spot.full_name()]
	var panel_node = spot_container.get_node_or_null(panel_name)
	if currently_showing_panel:
		currently_showing_panel.visible = false
		
	if panel_node:
		panel_node.visible = true
		currently_showing_panel = panel_node
	else:
		if spot is ProductionSpot:
			var spot_info_panel = SPOT_INFO_PRODUCTION.instantiate()
			spot_container.add_child(spot_info_panel)
			spot_info_panel.name = panel_name
			spot_info_panel.setup(spot)
			
			currently_showing_panel = spot_info_panel
			
		elif spot is TrainingSpot:
			var spot_info_panel = SPOT_INFO_TRAINING.instantiate()
			spot_container.add_child(spot_info_panel)
			spot_info_panel.name = panel_name
			spot_info_panel.setup(spot)
			
			currently_showing_panel = spot_info_panel

		elif spot is BuyingSpot:
			var spot_info_panel = SPOT_INFO_BUYING.instantiate()
			spot_container.add_child(spot_info_panel)
			spot_info_panel.name = panel_name
			spot_info_panel.setup(spot)
			
			currently_showing_panel = spot_info_panel
