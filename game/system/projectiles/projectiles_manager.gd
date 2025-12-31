class_name ProjectilesManager
extends Node2D

func _ready():
	add_to_group("projectile_manager")

func spawn(
  source: Node,
  projectile_scene: PackedScene,
  dir: Vector2,
  offset:= Vector2.ZERO
):
	var p := projectile_scene.instantiate()
	p.caster = source
	p.direction = dir
	p.offset += offset
	add_child(p)
