class_name BottomPanel
extends Panel

const SPOT_CONTAINER_SCENE = preload("res://scenes/ui/spot_container.tscn")

@onready var spot_container: HBoxContainer = $SpotContainer
@onready var crops_button: Button = %LeekCropsButton

@onready var spot: Spot = $"../../Areas/StartingVillage/Spots/LeekCrops"

func _ready() -> void:
	crops_button.pressed.connect(on_crops_pressed)
	
func on_crops_pressed():
	var spot_info: SpotContainer = SPOT_CONTAINER_SCENE.instantiate()
	spot_container.add_child(spot_info)
	spot_info.setup(spot)
