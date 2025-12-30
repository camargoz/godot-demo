extends PointLight2D

@onready var body := get_parent().get_node("Body") as AnimatedSprite2D

@export var pulse_speed := 4.0
@export var pulse_strength := 0.6
@export var base_energy := 0.2

var pulse_time := 0.0
var pulse_state := true

func _physics_process(delta: float) -> void:
	update_eye_light_position()
	pulse_eye_light(delta)

func update_eye_light_position():
	var anim := body.animation
	
	if anim.find("down") == -1:
		pulse_state = false
		return
	pulse_state = true

func pulse_eye_light(delta):
	if not pulse_state:
		energy = 0
		return
	pulse_time += delta * pulse_speed
	energy = base_energy + sin(pulse_time) * pulse_strength
