class_name Player2D
extends Entity2D

@onready var body := $Body as AnimatedSprite2D
@onready var hitbox := $Hitbox as Area2D

##### Spell Attributes #####
@export_category('Spell 1')
@export var spell_1_scene: PackedScene
@export var spell_1_coldown_s = 0.2

var spells: Dictionary[StringName, ProjectileData] = {
	'spell_1': ProjectileData.new(spell_1_coldown_s, handle_spell_1)
}

##### Attributes Player #####
@export_category('Player')
@export var damage_multiplier = 1.0
@export var speed = 150.0
var last_direction = Vector2.DOWN

###### Static Methods ######
func _ready():
	EntitiesManager.add_entity(self, 'players')
	body.material = body.material.duplicate(true)
	self._handle_ready()

func _physics_process(_delta: float):
	if alive:
		update_movement()
		update_animation()

func _input(event):
	if alive:
		for spell_name in spells.keys():
			if event.is_action_pressed(spell_name):
				cast_spell(spell_name)

func on_hit(meta: DamageData):
	var demage = meta.demage()
	var hitter = meta.source
	if alive:
		health -= demage
		hit_flash()
		if health <= 0:
			health = 0
			on_dead(hitter)
	handle_hit(hitter)

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

func on_dead(hitter: Node):
	alive = false
	hitbox.set_deferred('monitorable', false)
	body.play('dead')
	EntitiesManager.remove_entity(self, 'players')
	handle_dead(hitter)

func hit_flash():
	var mat := body.material as ShaderMaterial
	mat.set_shader_parameter("flash", 1.0)
	var tween := create_tween()
	tween.tween_property(mat, "shader_parameter/flash", 0.0, 0.1)

###### Spells Methods ######
func cast_spell(spell_name: StringName):
	var spell = spells[spell_name]
	if spell:
		spell.cast()

##### utils #####
func get_facing_vector() -> Vector2:
	var anim := body.animation
	if anim.contains("up"):
		return Vector2.UP
	if anim.contains("down"):
		return Vector2.DOWN
	if anim.contains("left"):
		return Vector2.LEFT
	return Vector2.RIGHT

##### Virtual Methods #####
func handle_spell_1():
	pass

func handle_hit(_hitter: Node):
	pass

func handle_dead(_killer: Node):
	pass
