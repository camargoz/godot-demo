class_name EnemySpawnData
extends Resource

@export var scene: PackedScene
@export var spawn_time: float

var last_spawn_ms: float = 0.0

func spawn(node: Node, position: Vector2):
  if scene:
    var p := scene.instantiate() as Entity2D
    p.global_position = position
    node.add_child(p)

