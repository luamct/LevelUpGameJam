class_name ProductionSpot
extends Spot

@export var requirements: Array[Requirement]
@export var gold_output: int  # Gold per second per working adventurer

@onready var production_timer: Timer = $ProductionTimer

func _ready() -> void:
	super()
	production_timer.timeout.connect(on_tick)

func on_tick():
	var gold = 0
	for adventurer in adventurers:
		if adventurer:
			gold += gold_output * production_timer.wait_time

	Globals.gold_collected.emit(gold)
