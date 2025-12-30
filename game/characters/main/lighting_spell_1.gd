extends PointLight2D

@export var pulse_speed := 5
@export var pulse_strength := 0.2
@export var base_energy := 0.1

var pulse_time := 0.0
var pulse_state := true

func _physics_process(delta: float) -> void:
	pulse_spell_light(delta)

func pulse_spell_light(delta):
	if not pulse_state:
		energy = 0
		return
	pulse_time += delta * pulse_speed
	energy = base_energy + sin(pulse_time) * pulse_strength
