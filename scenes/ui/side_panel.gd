class_name SidePanel
extends Panel

@onready var portrait_selector = %PortraitSelector
@onready var portraits_container: GridContainer = %PortraitsContainer

func _ready():
	# Connect signals for each portrait in the grid container
	for portrait: Control in portraits_container.get_children():
		portrait.mouse_entered.connect(func(): _on_portrait_hovered(portrait))
		portrait.mouse_exited.connect(_on_portrait_exited)

func _on_portrait_hovered(portrait: Control):
	#portrait_selector.global_position = portrait.global_position - Vector2((portrait_selector.rect_size.x - portrait.rect_size.x) / 2, (portrait_selector.rect_size.y - portrait.rect_size.y) / 2)
	portrait_selector.reparent(portrait)
	portrait_selector.position = Vector2.ZERO
	
	portrait_selector.visible = true

func _on_portrait_exited():
	portrait_selector.visible = false
