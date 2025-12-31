extends Player2D

@onready var shadow := $Shadow as AnimatedSprite2D

##### Static Methods #####
func _ready():
	EntitiesManager.players.append(self)
	shadow.play('default')

##### Methods #####
func handle_spell_1():
	var manager = get_tree().get_first_node_in_group("projectile_manager")
	if manager:
		var mouse_pos := get_global_mouse_position()
		manager.spawn(self, spell_1_scene, mouse_pos, get_facing_vector()*10)

func handle_hit(_hitter: Node):
	print('player ', self.name, ': ', health, ' hp')

func handle_dead(killer: Node):
	shadow.play('dead')
	print('player ', self, ' is killed by ', killer)
