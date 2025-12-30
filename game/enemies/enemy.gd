class_name Enemy2D
extends CharacterBody2D

@onready var body := $Body as AnimatedSprite2D
@onready var hitbox := $Hitbox as Area2D

##### Attributes Enemy #####
@export var health = 100.0
var alive = true

func _physics_process(_delta: float) -> void:
	pass

func on_hit(meta: Dictionary):
	var demage = meta.get_or_add('demage', 0)
	if alive:
		health -= demage
		hit_flash()
		if health <= 0:
			health = 0
			alive = false
			hitbox.set_deferred('monitorable', false)
			body.play('dead')
	hit(meta.get('hitter'))

##### Method #####
func hit(_hitter: Node2D):
	pass

func hit_flash():
	var mat := body.material as ShaderMaterial
	mat.set_shader_parameter("flash", 1.0)
	var tween := create_tween()
	tween.tween_property(mat, "shader_parameter/flash", 0.0, 0.1)
