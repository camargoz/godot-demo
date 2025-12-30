class_name ProjectilesManager
extends Node

func _ready():
	add_to_group("projectile_manager")

func spawn(
  source: Node,
  projectile_scene: PackedScene,
  dir: Vector2,
  offset:= Vector2.ZERO,
  post_stop:= func(_caster: Node2D): pass
):
	var p := projectile_scene.instantiate()
	p.direction = dir.normalized()
	p.caster = source
	p.offset = offset
	p.post_stop = post_stop
	add_child(p)
