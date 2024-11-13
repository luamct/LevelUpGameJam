class_name BottomPanel
extends Panel

@onready var spot_container: HBoxContainer = $SpotContainer
@onready var crops_button: Button = %LeekCropsButton
@onready var trainer_button: Button = %TrainerButton

# GAMBI! 
# TODO: add buttons according to the spots on the adventurers current area
@onready var crops_spot: Spot = $"../../Areas/StartingVillage/Spots/LeekCrops"
@onready var trainer_spot: Spot = $"../../Areas/StartingVillage/Spots/Trainer"

@onready var spot_info_production: SpotInfoProduction = %SpotInfoProduction
@onready var spot_info_training: SpotInfoTraining = %SpotInfoTraining

func _ready() -> void:
	crops_button.pressed.connect(on_crops_pressed)
	trainer_button.pressed.connect(on_trainer_pressed)

func on_crops_pressed():
	spot_info_training.visible = false
	spot_info_production.visible = true
	spot_info_production.setup(crops_spot)

func on_trainer_pressed():
	spot_info_production.visible = false
	spot_info_training.visible = true
	spot_info_training.setup(trainer_spot)
