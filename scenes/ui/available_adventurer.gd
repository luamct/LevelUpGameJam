class_name AvailableAdventurer
extends VBoxContainer

@onready var portrait = $HirePortraitPanel/Portrait
@onready var button = $HirePortraitPanel/Button

func setup(adventurer: Adventurer):
	portrait.set_portrait_texture(adventurer.portrait)
