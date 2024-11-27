class_name AvailableAdventurer
extends VBoxContainer

@onready var portrait = $HirePortraitPanel/Portrait
@onready var button = $HirePortraitPanel/Button
@onready var hire_button = $HireButton

func setup(adventurer: Adventurer):
	portrait.set_portrait_texture(adventurer.portrait)
