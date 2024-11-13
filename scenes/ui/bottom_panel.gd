class_name BottomPanel
extends Panel

@onready var spot_container: HBoxContainer = $SpotContainer
@onready var buttons_container: VBoxContainer = $SpotContainer/ButtonsContainer

@onready var spot_info_production: SpotInfoProduction = %SpotInfoProduction
@onready var spot_info_training: SpotInfoTraining = %SpotInfoTraining

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
			button.text = spot.name_
			button.pressed.connect(func(): on_spot_button_pressed(spot))
			buttons_container.add_child(button)

func on_spot_button_pressed(spot: Spot):
	if spot is ProductionSpot:
		spot_info_training.visible = false
		spot_info_production.visible = true
		spot_info_production.setup(spot)
		
	elif spot is TrainingSpot:
		spot_info_production.visible = false
		spot_info_training.visible = true
		spot_info_training.setup(spot)

	elif spot is BuyingSpot:
		print("TODO")
		
	
