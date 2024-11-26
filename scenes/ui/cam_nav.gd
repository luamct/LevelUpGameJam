extends Camera2D

var dragging = false
var map_limits = Rect2()
var pan_speed = 200
var zoom_step = 0.05
var min_zoom = 0.5
var max_zoom = 2.5

@onready var background = $"../Background"

func _ready():
	if background and background.texture:
		var map_size = background.texture.get_size() * background.scale
		map_limits = Rect2(background.position - map_size / 2, map_size)

# Camera navigation using WASD
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
	
	var half_viewport = (get_viewport_rect().size / zoom) / 2.0
	
	var new_position = position + cam_movement * pan_speed * delta
	position = new_position.clamp(map_limits.position + half_viewport, map_limits.end - half_viewport)

# Navigation and zoom using the mouse middle button
func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			dragging = event.pressed
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = (zoom + Vector2(zoom_step, zoom_step)).clampf(min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = (zoom - Vector2(zoom_step, zoom_step)).clampf(min_zoom, max_zoom)
			
	elif event is InputEventMouseMotion and dragging:
		position -= event.relative / zoom
	
