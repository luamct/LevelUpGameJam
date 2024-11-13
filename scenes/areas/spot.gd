class_name Spot
extends Node2D

@export var name_: String
@export var type: Enums.SpotType

@export var requirements: Array[Requirement]
@export var gold_output: int  # Gold per second per working adventurer

@export var level_cost: int # How much it costs to level up an adventurer (in gold)
@export var level_time: int # How long does it take to level up one adventurer (in seconds)

@export var slots: int # Number of available slots
