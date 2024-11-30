class_name SidePanel
extends Panel

const PORTRAIT_SCENE = preload("res://scenes/ui/portrait.tscn")

@onready var gold_value: Label = %GoldContainer/Value
@onready var portraits_container: GridContainer = %PortraitsContainer
@onready var adventurer_stats: VBoxContainer = %AdventurerStats
@onready var bottom_panel: BottomPanel = %BottomPanel

@onready var name_label: Label = %NameLabel
@onready var level_value: Label = %LevelContainer/Value
@onready var strength_value: Label = %StrengthValue
@onready var speed_value: Label = %SpeedValue
@onready var agility_value: Label = %AgilityValue
@onready var defense_value: Label = %DefenseValue
@onready var attack_value: Label = %AttackValue
@onready var morale_value: Label = %MoraleValue
@onready var discipline_value: Label = %DisciplineValue
@onready var class_value = %ClassValue

@onready var adventurer_location = %AdventurerLocation
@onready var adventurer_spot = %AdventurerSpot

@onready var attributes_container: GridContainer = %AttributesContainer

@onready var tutorial_button: Button = %TutorialButton
@onready var tutorial_screen: TextureRect = $"../TutorialScreen"
@onready var level_up_sfx = $LevelUpSFX

var selected_portrait: Portrait
var adventurers: Array[Adventurer]

func _ready():
	adventurers.assign($"../../Adventurers".get_children())
	
	Globals.gold_updated.connect(on_gold_updated)
	Globals.hired_adventurer.connect(on_hired_adventurer)
	Globals.update_side_panel.connect(update_adventurer_panel)
	
	# Connect signals for each portrait in the grid container
	for adventurer: Adventurer in adventurers:
		add_adventurer_to_panel(adventurer)
	
	# Show the level up buttons if there are levels to attribute
	for attribute: String in Globals.attributes:
		var level_up_button: Button = get_level_up_button(attribute)
		level_up_button.pressed.connect(func(): on_level_up_button_pressed(attribute.to_lower()))

	tutorial_button.pressed.connect(on_tutorial_button_pressed)

func on_tutorial_button_pressed():
	tutorial_screen.start()
	
func on_portrait_input_event(event: InputEvent, portrait: Portrait, adventurer: Adventurer):
	if event.is_action_pressed("left_click"):
		bottom_panel.update_buttons(adventurer)
		Globals.adventurer_selected(adventurer)

		if selected_portrait:
			selected_portrait.unselect()
			
		portrait.select()
		selected_portrait = portrait
		
		adventurer_stats.visible = true

		update_adventurer_panel()

func update_adventurer_panel():
	var adventurer = Globals.selected_adventurer
	name_label.text = adventurer.name_
	level_value.text = level_string(adventurer)
	
	class_value.text = adventurer.class_name_value(adventurer.class_)
	
	strength_value.text = str(adventurer.strength)
	speed_value.text = str(adventurer.speed)
	agility_value.text = str(adventurer.agility)
	defense_value.text = str(adventurer.defense)
	attack_value.text = str(adventurer.attack)
	morale_value.text = str(adventurer.morale)
	discipline_value.text = str(adventurer.discipline)

	for attribute: String in Globals.attributes:
		get_level_up_button(attribute).visible = adventurer.new_levels > 0
	
	if adventurer.area:
		var area_activity = "Location: " + adventurer.area.name 
		adventurer_location.text = area_activity 
	else:
		adventurer_location.text = adventurer.name_ + " is travelling."
	if adventurer.spot:
		var spot_activity = "Activity: " + adventurer.spot.name
		adventurer_spot.text = spot_activity
	else:
		if adventurer.area:
			adventurer_spot.text = "Activity: Chilling."
		else: 
			adventurer_spot.text = ""

func get_level_up_button(attribute: String):
	return attributes_container.get_node("%sLevelUp/Button" % [attribute])
	
func level_string(adventurer: Adventurer):
	var level_str = str(adventurer.level)
	if adventurer.new_levels > 0:
		level_str += " (+%d)" % [adventurer.new_levels]
	return level_str

func on_level_up_button_pressed(attribute_name: String):
	Globals.selected_adventurer.level_up_attribute(attribute_name)
	update_adventurer_panel()
	level_up_sfx.play()
	
func on_gold_updated(current_gold: int):
	gold_value.text = str(current_gold)

func on_hired_adventurer(adventurer: Adventurer):
	adventurers.append(adventurer)
	add_adventurer_to_panel(adventurer)
	adventurer.sprite.show()
	
func add_adventurer_to_panel(adventurer: Adventurer):
	var portrait: Control = PORTRAIT_SCENE.instantiate()
	portraits_container.add_child(portrait)
	portrait.set_portrait_texture(adventurer.portrait)

	portrait.gui_input.connect(func(event: InputEvent): on_portrait_input_event(event, portrait, adventurer))
	adventurer.level_gained.connect(update_adventurer_panel)
	adventurer.level_up.connect(update_adventurer_panel)
