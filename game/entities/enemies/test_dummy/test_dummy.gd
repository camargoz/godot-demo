extends Enemy2D

@onready var shadow := $Shadow as AnimatedSprite2D

##### Attack Attributes #####
@export_category('movement')
@export var max_speed: float = 50.0
@export var acceleration := 100.0
@export_category('target')
@export var target_list: Array[String] = []
var target_selector: TargetSelectorData
var target_distance_max: float = 20.0
@export_category('attack')
@export var attack_scene: PackedScene
@export var attack_coldown_s = 2.0
var attack_data: ProjectileData
@export_category('aux test')
@export var color: Color

##### Static Methods #####
func _handle_ready() -> void:
	if color:
		var mat := body.material as ShaderMaterial
		mat.set_shader_parameter("base_color", color)
	target_selector = TargetSelectorData.new(target_list)
	attack_data = ProjectileData.new(attack_coldown_s, handle_attack)

func _process(delta: float) -> void:
	if not alive:
		return
	
	var target = target_selector.get_target()
	if target:
		var target_close = target_distance_max > target_selector.get_distance_target(global_position)
		if not target_close:
			move_to_target(target, delta)
		else:
			attack_data.cast()
	else:
		target_selector.update(delta, global_position)

func handle_hit(_hitter: Node):
	print('enemy ', self, ': ', health, ' hp')

func handle_dead(hitter: Node):
	shadow.play('dead')
	print('enemy ', self, ' is killed by ', hitter)

##### Methods #####
func handle_attack():
	var manager = get_tree().get_first_node_in_group("projectile_manager")
	var target = target_selector.get_target()
	if manager and target:
		var offset = Vector2(0.0, -12.0)
		manager.spawn(self, attack_scene, target.global_position+offset)

func move_to_target(target: Entity2D, delta: float):
	var dir = (target.global_position-global_position).normalized()
	if dir != Vector2.ZERO:
		velocity = velocity.move_toward(dir * max_speed, acceleration * delta)
	move_and_slide()
