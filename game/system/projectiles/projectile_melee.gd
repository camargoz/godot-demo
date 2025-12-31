class_name ProjectileMelee
extends Area2D

@export var timer : Timer
@export var projectile : AnimatedSprite2D
@export var collision : CollisionShape2D
@export var offset := Vector2.ZERO
@export var canalize_duration = 0.2
@export var attack_radius := 16.0
@export var base_damage := 0.0

###### Attributes ######
var direction := Vector2.ZERO
var caster: Node = Node.new()

###### Static Methods ######
func _ready() -> void:
	set_attack_position()
	projectile.play('canalize')
	timer.wait_time = canalize_duration
	timer.start()
	timer.timeout.connect(attack_projectile)

func _on_area_entered(area: Area2D) -> void:
	var body_hit = area.owner
	print('acertei: ', body_hit)
	if body_hit.has_method('on_hit'):
		body_hit.on_hit(hit())

func _on_animation_finished():
	if projectile.animation == "attack":
		queue_free()

###### Methods ######
func hit() -> DamageData:
	var multiplier = caster.damage_multiplier if 'damage_multiplier' in caster else 1
	return DamageData.new(base_damage, multiplier, caster)     

func attack_projectile():
	self.set_deferred('monitoring', true)
	projectile.play('attack')

func set_attack_position():
	global_position = caster.global_position + offset
	direction = (direction - global_position).normalized()
	rotation = direction.angle()
	var postion_spawn = Vector2(attack_radius, 0)
	projectile.position = postion_spawn
	collision.position = postion_spawn
