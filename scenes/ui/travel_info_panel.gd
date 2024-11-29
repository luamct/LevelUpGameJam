class_name TravelInfoPanel
extends HBoxContainer

@onready var destination_buttons: VBoxContainer = $DestinationButtons
@onready var panel_info_container: GridContainer = $PathInfoContainer
@onready var distance_value: Label = %DistanceValue
@onready var travel_time_value: Label = %TravelTimeValue

func setup(adventurer: Adventurer):
	if adventurer.area:
		for path in adventurer.area.paths:
			var button: Button = Button.new()
			if path.starts_at == adventurer.area:
				button.text = path.ends_at.name
			else:
				button.text = path.starts_at.name

			button.mouse_entered.connect(func(): on_travel_button_hovered(adventurer.area, path))
			button.pressed.connect(func(): on_travel_button_clicked(adventurer.area, path))
			destination_buttons.add_child(button)

func on_travel_button_hovered(from_area: Area, path: TravelPath):
	distance_value.text = str(path.distance)
	var travel_time = path.distance / Globals.selected_adventurer_speed()
	travel_time_value.text = str(travel_time)

func on_travel_button_clicked(from_area: Area, path: TravelPath):
	var adventurer = Globals.selected_adventurer
	if adventurer.spot:
		adventurer.spot.try_to_remove_adventurer(adventurer)
	adventurer.start_traveling(from_area, path)
	
