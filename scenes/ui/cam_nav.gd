extends Camera2D


var drag_start = Vector2()
var dragging = false
var map_limits = Rect2()
var viewport_size = Vector2()
var zoom_step = 0.1  # Define o quanto o zoom vai aumentar ou diminuir a cada rotação
var min_zoom = Vector2(0.5, 0.5)  # Limite máximo de zoom (mais próximo)
var max_zoom = Vector2(2, 2)      # Limite mínimo de zoom (mais distante)

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
				
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			adjust_zoom(zoom_step)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			adjust_zoom(-zoom_step)
				
	elif event is InputEventMouseMotion and dragging:
		var offset = drag_start - get_global_mouse_position()
		drag_start = get_global_mouse_position()
		position += offset
		
func adjust_zoom(step):
	var new_zoom = zoom + Vector2(step, step)
	var camera_size = viewport_size * new_zoom
	print("Camera size: " + str(camera_size))
	print("Map limits: " + str(map_limits.size))
	if camera_size.x > map_limits.size.x or camera_size.y > map_limits.size.y:
		return  
	set_zoom_level(new_zoom)

func set_zoom_level(new_zoom):
	print("Position antes do zoom: " + str(position))
	zoom.x = clamp(new_zoom.x, min_zoom.x, max_zoom.x)
	zoom.y = clamp(new_zoom.y, min_zoom.y, max_zoom.y)
	position = position * new_zoom
	print("Position depois do zoom: " + str(position))
