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

func add_xp(new_xp: int):
	xp += new_xp
	if xp >= Globals.xp_table[level]:
		level += 1
		level_up.emit(level)
	
