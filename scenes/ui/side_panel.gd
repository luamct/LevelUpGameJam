class_name SidePanel
extends Panel

const PORTRAIT_SCENE = preload("res://scenes/ui/portrait.tscn")

@onready var portrait_selector = %PortraitSelector
@onready var portraits_container: GridContainer = %PortraitsContainer

@onready var adventurers: Array[Adventurer]

func _ready():
	adventurers.assign($"../../Adventurers".get_children())
	
	# Connect signals for each portrait in the grid container
	for adventurer: Adventurer in adventurers:
		
		var portrait: Control = PORTRAIT_SCENE.instantiate()
		portraits_container.add_child(portrait)
		portrait.set_portrait_texture(adventurer.portrait)
		
		portrait.mouse_entered.connect(func(): _on_portrait_hovered(portrait))
		portrait.mouse_exited.connect(_on_portrait_exited)

func _on_portrait_hovered(portrait: Control):
	#portrait_selector.global_position = portrait.global_position - Vector2((portrait_selector.rect_size.x - portrait.rect_size.x) / 2, (portrait_selector.rect_size.y - portrait.rect_size.y) / 2)
	portrait_selector.reparent(portrait)
	portrait_selector.position = Vector2.ZERO
	
	portrait_selector.visible = true

func _on_portrait_exited():
	portrait_selector.visible = false
