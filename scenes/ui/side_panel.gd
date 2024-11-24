class_name SidePanel
extends Panel

const PORTRAIT_SCENE = preload("res://scenes/ui/portrait.tscn")

@onready var gold_value: Label = %GoldContainer/Value
@onready var portrait_selector = %PortraitSelector
@onready var portraits_container: GridContainer = %PortraitsContainer
@onready var adventurer_stats: VBoxContainer = %AdventurerStats
@onready var bottom_panel: BottomPanel = %BottomPanel

@onready var name_label: Label = %NameLabel
@onready var level_value: Label = %LevelContainer/Value
@onready var strength_value: Label = %StrengthContainer/Value
@onready var speed_value: Label = %SpeedContainer/Value
@onready var agility_value: Label = %AgilityContainer/Value
@onready var defense_value: Label = %DefenseContainer/Value
@onready var attack_value: Label = %AttackContainer/Value
@onready var morale_value: Label = %MoraleContainer/Value
@onready var discipline_value: Label = %DisciplineContainer/Value

var adventurers: Array[Adventurer]

func _ready():
	adventurers.assign($"../../Adventurers".get_children())
	
	Globals.gold_updated.connect(on_gold_updated)
	
	# Connect signals for each portrait in the grid container
	for adventurer: Adventurer in adventurers:
		var portrait: Control = PORTRAIT_SCENE.instantiate()
		portraits_container.add_child(portrait)
		portrait.set_portrait_texture(adventurer.portrait)

		portrait.gui_input.connect(func(event: InputEvent): on_portrait_input_event(event, portrait, adventurer))
		#portrait.mouse_entered.connect(func(): _on_portrait_hovered(portrait, adventurer))
		#portrait.mouse_exited.connect(_on_portrait_exited)

func on_portrait_input_event(event: InputEvent, portrait: Control, adventurer: Adventurer):
	if event.is_action_pressed("left_click"):
		bottom_panel.update_buttons(adventurer)
		Globals.adventurer_selected(adventurer)
		
		portrait_selector.reparent(portrait)
		portrait_selector.position = Vector2.ZERO

		portrait_selector.visible = true
		adventurer_stats.visible = true

		name_label.text = adventurer.name_
		level_value.text = str(adventurer.level)
		strength_value.text = str(adventurer.strength)
		speed_value.text = str(adventurer.speed)
		agility_value.text = str(adventurer.agility)
		defense_value.text = str(adventurer.defense)
		attack_value.text = str(adventurer.attack)
		morale_value.text = str(adventurer.morale)
		discipline_value.text = str(adventurer.discipline)


func on_gold_updated(current_gold: int):
	gold_value.text = str(current_gold)
