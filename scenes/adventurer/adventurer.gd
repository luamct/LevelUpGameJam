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

@export var area: Area
@export var spot: Spot

@export var traveling_in: TravelPath
@export var traveling_from: Area
var position_on_path: float   # As a percentage of the path

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	global_position = area.global_position
	
func add_xp(new_xp: int):
	xp += new_xp
	if xp >= Globals.xp_table[level]:
		level += 1
		level_up.emit(level)

func start_traveling(from_area: Area, path: TravelPath):
	position_on_path = 0.0
	traveling_in = path
	traveling_from = from_area

func add_to_spot(_spot: Spot):
	spot = _spot
	global_position = spot.area.global_position

func _process(delta: float):
	if traveling_in:
		var distance = Globals.calculate_speed(self) * delta
		position_on_path += distance / traveling_in.distance
		
		global_position = traveling_in.get_position_in_path(position_on_path)
		#print(position_on_path, " => ", global_position)
		if position_on_path >= 1.0:
			print("Chegoooo")
	
