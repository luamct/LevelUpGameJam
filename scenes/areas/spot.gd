class_name Spot
extends Node2D

signal adventurer_added(adventurer: Adventurer, slot_number: int)
signal adventurer_removed(adventurer: Adventurer, slot_number: int)

# Number of available slots
@export var slots: int

# Always has "slots" items, one for each slot on this spot. A non-null 
# value at index i means an adventurer is working on that slot
var adventurers: Array[Adventurer]

@onready var area: Area = $"../.."
@onready var travelling_sfx = $TravellingSFX
@onready var training_sfx = $TrainingSFX
@onready var production_sfx = $ProductionSFX

func _ready() -> void:
	for i in slots:
		adventurers.append(null)

func try_to_add_adventurer(_adventurer: Adventurer, _slot_number: int) -> bool:
	assert(false, "Method not implemented on subclass")
	return false

func try_to_remove_adventurer(_adventurer: Adventurer) -> bool:
	assert(false, "Method not implemented on subclass")
	return false
	
# Unique name including area name
func full_name() -> String:
	return "%s_%s" % [area.name, name]
	
func play_audio_for_duration(audio_player: AudioStreamPlayer, duration: float):
	if audio_player.stream:
		audio_player.stop() # Garante que o áudio não está tocando
		audio_player.play() # Toca o áudio do início
		# Configura um Timer para parar o áudio após o tempo desejado
		var timer = Timer.new()
		timer.wait_time = duration
		timer.one_shot = true
		add_child(timer)
		timer.connect("timeout", Callable(self, "_on_timer_timeout"))
		timer.start()
	else:
		print("Nenhum áudio carregado no AudioStreamPlayer!")

func _on_timer_timeout(audio_player: AudioStreamPlayer):
	audio_player.stop() # Para o áudio quando o Timer dispara
