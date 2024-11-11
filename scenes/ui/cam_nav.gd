extends Camera2D


var drag_start = Vector2()
var dragging = false
var map_limits = Rect2()
var viewport_size = Vector2()

@onready var background = $"../Background"

func _ready():
	if background and background.texture:
		var map_size = background.texture.get_size() * background.scale
		map_limits = Rect2(background.position - map_size / 2, map_size)
		
	viewport_size = get_viewport_rect().size

# Navegação através de teclas WASD e Direcionais
func _process(delta):
	var cam_movement = Vector2()

	if Input.is_action_pressed("nav_up"):
		cam_movement.y -= 1
	if Input.is_action_pressed("nav_down"):
		cam_movement.y += 1
	if Input.is_action_pressed("nav_left"):
		cam_movement.x -= 1
	if Input.is_action_pressed("nav_right"):
		cam_movement.x += 1
	
	var new_position = position + cam_movement * 500 * delta
	position.x = clamp(new_position.x, map_limits.position.x, map_limits.position.x + map_limits.size.x - viewport_size.x)
	position.y = clamp(new_position.y, map_limits.position.y, map_limits.position.y + map_limits.size.y - viewport_size.y)

# Navegação através do mouse
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				drag_start = get_global_mouse_position()
				dragging = true
			else:
				dragging = false
				
	elif event is InputEventMouseMotion and dragging:
		var offset = drag_start - get_global_mouse_position()
		drag_start = get_global_mouse_position()
		position += offset
		
