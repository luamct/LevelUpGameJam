class_name Adventurer
extends Node2D

signal level_up(int)

@export var name_: String
@export var portrait: Texture2D

@export var strength: int
@export var speed: int
@export var agility: int
@export var defense: int
@export var attack: int
@export var morale: int
@export var discipline: int

@export var xp: int
@export var level: int

@export var hire_cost: int

@export var area: Area
@export var spot: Spot

# Path2D are directional, so this value tells if the adventurer is 
# coming from the start of the path (value 1), or at the end (value -1)
@export var traveling_direction: int
@export var traveling_in: TravelPath
var position_on_path: float   # As a percentage of the path

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	if area:
		global_position = area.global_position
	
func add_xp(new_xp: int):
	xp += new_xp
	if xp >= Globals.xp_table[level]:
		level += 1
		level_up.emit(level)

func start_traveling(from_area: Area, path: TravelPath):
	remove_from_spot()
	traveling_in = path
	
	if from_area == path.starts_at:
		traveling_direction = 1
		position_on_path = 0.0
	else:
		traveling_direction = -1
		position_on_path = 1.0
		
	Globals.update_bottom_panel.emit(self)

func add_to_spot(_spot: Spot):
	spot = _spot
	area = _spot.area
	global_position = spot.area.global_position

func remove_from_spot():
	spot = null
	area = null
	
func _process(delta: float):
	if traveling_in:
		var distance = Globals.calculate_speed(self) * delta
		
		# Because of the factor traveling_direction, we're incrementing 
		# towards 1 if traveling_direction = 1, or decrementing towards 
		# 0 if traveling_direction = -1
		position_on_path += (distance / traveling_in.distance) * traveling_direction

		global_position = traveling_in.get_position_in_path(position_on_path)
		if traveling_direction == 1 and position_on_path >= 1.0:
			arrived_at(traveling_in.ends_at)
		elif traveling_direction == -1 and position_on_path <= 0.0:
			arrived_at(traveling_in.starts_at)
	
func arrived_at(_area: Area):
	area = _area
	area.visited()
	global_position = area.global_position
	traveling_in = null
	Globals.update_bottom_panel.emit(self)
