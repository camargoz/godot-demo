class_name Enemy2D
extends Entity2D

@onready var timer := $Timer as Timer
@onready var hitbox := $Hitbox as Area2D
@onready var body := $Body as AnimatedSprite2D

##### Attributes Enemy #####
@export var after_dead_time = 5.0

##### Static Methods #####
func _ready() -> void:
	EntitiesManager.add_enemy(self)
	body.material = body.material.duplicate(true)
	self._handle_ready()

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

##### Method #####
func on_dead(hitter: Node):
	EntitiesManager.remove_enemy(self)
	alive = false
	hitbox.set_deferred('monitorable', false)
	body.play('dead')
	handle_dead(hitter)
	timer.wait_time = after_dead_time
	timer.start()
	timer.timeout.connect(queue_free)

func hit_flash():
	var mat := body.material as ShaderMaterial
	mat.set_shader_parameter("flash", 1.0)
	var tween := create_tween()
	tween.tween_property(mat, "shader_parameter/flash", 0.0, 0.1)

##### Virtual Methods #####
func handle_hit(_hitter: Node):
	pass

func handle_dead(_hitter: Node):
	pass
