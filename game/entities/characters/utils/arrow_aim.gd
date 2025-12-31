extends Node2D

@onready var arrow := $Arrow

@export var arrow_offset := Vector2.ZERO
@export var arrow_radius := 64.0

func _ready():
	self.global_position += arrow_offset

func _process(_delta):
	var mouse_pos := get_global_mouse_position()
	var dir := mouse_pos - global_position
	if dir.length() == 0:
		return
	var angle := dir.angle()
	self.rotation = angle
	arrow.position = Vector2(arrow_radius, 0)
