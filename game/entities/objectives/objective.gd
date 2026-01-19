class_name Objective2D
extends Entity2D

@onready var timer := $Timer as Timer
@onready var hitbox := $Hitbox as Area2D
@onready var body := $Body as AnimatedSprite2D

@export_category('attributes')
@export var tick_time: float = 2.0

##### Static Methods #####
func _ready() -> void:
	EntitiesManager.add_entity(self, 'objectives')
	body.material = body.material.duplicate(true)
	timer.timeout.connect(on_tick)
	self._handle_ready()

	##### Only tests #####
	self.on_start_tick_timer()
	#####

func on_hit(meta: DamageData):
	var demage = meta.demage()
	var hitter = meta.source
	if alive:
		health -= demage
		hit_flash()
		if health <= 0:
			health = 0
			on_destroy(hitter)
	handle_hit(hitter)

##### Method #####
func on_start_tick_timer():
	timer.wait_time = tick_time
	timer.start()

func on_tick():
	if alive:
		on_start_tick_timer()
		var parent = get_parent()
		if parent.has_method('add_tick'):
			parent.add_tick()

func on_destroy(hitter: Node):
	alive = false
	hitbox.set_deferred('monitorable', false)
	body.play('destroyed')
	handle_destroyed(hitter)

func hit_flash():
	var mat := body.material as ShaderMaterial
	mat.set_shader_parameter("flash", 1.0)
	var tween := create_tween()
	tween.tween_property(mat, "shader_parameter/flash", 0.0, 0.1)

##### Virtual Methods #####
func handle_hit(_hitter: Node):
	print('objective ', self.name, ': ', health, ' hp')
	pass

func handle_destroyed(hitter: Node):
	print('objective ', self, ' is destroyed by ', hitter)
	pass
