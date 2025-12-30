class_name Player2D
extends CharacterBody2D

@onready var body := $Body as AnimatedSprite2D

@export var spell_1_scene: PackedScene
@export var damage_multiplier = 1.0
@export var speed = 150.0

var last_direction = Vector2.DOWN

###### Static Methods ######
func _physics_process(_delta: float):
	update_movement()
	update_animation()

func _input(event):
	if event.is_action_pressed("spell_1"):
		spell_1()

###### Methods ######
func update_movement():
	var input_dir := Vector2.ZERO

	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		velocity = input_dir * speed
		last_direction = input_dir
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func update_animation():
	if velocity.length() > 0:
		play_run_animation(velocity)
	else:
		play_idle_animation()

func play_run_animation(dir: Vector2):
	if abs(dir.x) < abs(dir.y):
		if dir.y > 0:
			body.play("run_down")
		else:
			body.play("run_up")
	else:
		if dir.x > 0:
			body.play("run_right")
		else:
			body.play("run_left")

func play_idle_animation():
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			body.play("idle_right")
		else:
			body.play("idle_left")
	else:
		if last_direction.y > 0:
			body.play("idle_down")
		else:
			body.play("idle_up")

func get_mouse_direction() -> Vector2:
	var mouse_pos := get_global_mouse_position()
	return (mouse_pos - global_position).normalized()

func get_facing_vector() -> Vector2:
	var anim := body.animation
	if anim.contains("up"):
		return Vector2.UP
	if anim.contains("down"):
		return Vector2.DOWN
	if anim.contains("left"):
		return Vector2.LEFT
	return Vector2.RIGHT

###### Spells ######
func spell_1():
	var manager = get_tree().get_first_node_in_group("projectile_manager")
	if manager:
		var dir := get_mouse_direction()
		manager.spawn(self, spell_1_scene, dir)
