extends Panel

@export_category('player_attach')
@export var player: Node2D
@export_category('labels_attach')
@export var fps_value: Label
@export var pos_value: Label
@export var player_name_value: Label
@export var players_amount_value: Label
@export var enemies_amount_value: Label
@export_category('buttons_attach')
@export var add_enemy_button: Button
@export var enemy_scene: PackedScene
@export var entities_node: Node2D

func _ready() -> void:
	add_enemy_button.pressed.connect(add_enemy)

func _process(_delta):
	fps_value.text = '%d' % Engine.get_frames_per_second()
	if player:
		player_name_value.text = player.name
		pos_value.text = '(%.1f, %.1f)' % [player.global_position.x, player.global_position.y]
	players_amount_value.text = '%d' % EntitiesManager.players.size()
	enemies_amount_value.text = '%d' % EntitiesManager.enemies.size()

func add_enemy():
	var scene = enemy_scene.instantiate() as Enemy2D
	scene.global_position = player.global_position + (Vector2.LEFT*60)
	entities_node.add_child(scene)
