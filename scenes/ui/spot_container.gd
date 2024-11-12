class_name SpotContainer
extends HBoxContainer

@onready var name_label: Label = %NameLabel
@onready var requirements_container: VBoxContainer = %RequirementsContainer
@onready var gold_output_value: Label = %GoldOutputValue

func setup(spot: Spot):
	name_label.text = spot.name_
	for requirement in spot.requirements:
		print(requirement.attribute, requirement.minimum_value)
		var label = Label.new()
		label.text = "%d+ %s" % [requirement.minimum_value, Enums.as_string(requirement.attribute)]
		requirements_container.add_child(label)

func _ready() -> void:
	pass
