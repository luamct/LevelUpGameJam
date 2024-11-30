class_name Adventurer
extends Node2D

signal level_gained  # When a level is gained
signal level_up      # When a gained level is used to increase an attribute

@export var name_: String
@export var class_: Enums.Class
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

# Levels that were gained but not attributed yet
var new_levels: int = 0

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
	
# Checks if we've hit the next entry in the xp table, using level + 
# new_levels, since the player may not have attributed all levels yet
func add_xp(new_xp: int):
	xp += new_xp
	if xp >= Globals.xp_table[level + new_levels]:
		new_levels += 1
		level_gained.emit()

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
	Globals.update_side_panel.emit()
	
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
	if self == Globals.selected_adventurer:
		Globals.update_bottom_panel.emit(self)
		Globals.update_side_panel.emit()
	
func level_up_attribute(attribute_name: String):
	new_levels -= 1
	level += 1
	set(attribute_name, get(attribute_name) + 1)
	level_up.emit()

func attribute_value(attribute: Enums.Attribute) -> int:
	match attribute:
		Enums.Attribute.STRENGTH: return strength
		Enums.Attribute.SPEED: return speed
		Enums.Attribute.AGILITY: return agility
		Enums.Attribute.DEFENSE: return defense
		Enums.Attribute.MORALE: return morale
		Enums.Attribute.ATTACK: return attack
		Enums.Attribute.DISCIPLINE: return discipline
	return 0

func class_name_value(class_: Enums.Class) -> String:
	match class_:
		Enums.Class.FIGHTER: return "fighter"
		Enums.Class.BARD: return "bard"
		Enums.Class.PALADIN: return "paladin"
		Enums.Class.SORCERER: return "sorcerer"
		Enums.Class.DRUID: return "druid"
		Enums.Class.ROGUE: return "rogue"
	return ""

func play_animation(animation_name: String):
	if sprite.animation != animation_name:
		sprite.play(animation_name)

func total_level() -> int:
	return level + new_levels
