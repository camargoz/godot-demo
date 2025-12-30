class_name ProjectileChild
extends Area2D

@export var timer : Timer
@export var projectile : AnimatedSprite2D
@export var collision : CollisionShape2D
@export var speed := 300.0
@export var lifetime := 0.5
@export var base_damage := 0

###### Attributes ######
var offset := Vector2.ZERO
var direction := Vector2.ZERO
var caster := Node2D
var post_stop := func(_caster: Node2D): pass

###### Static Methods ######
func _ready() -> void:
	global_position = caster.global_position + offset
	rotation = direction.angle()
	projectile.play("default")
	timer.wait_time = lifetime
	timer.start()
	timer.timeout.connect(stop_projectile)

func _process(delta: float) -> void:
	update_pos(delta)

func _on_area_entered(area: Area2D) -> void:
	var body_hit = area.owner
	if body_hit.has_method('on_hit'):
		body_hit.on_hit(hit())
	queue_free()

###### Methods ######
func update_pos(delta: float):
	global_position += direction * speed * delta

func stop_projectile():
	post_stop.call(caster)
	queue_free()

func hit() -> Dictionary:
	return {
		"hitter": caster,
		"demage": base_damage * float(caster.damage_multiplier or 1)
	}
