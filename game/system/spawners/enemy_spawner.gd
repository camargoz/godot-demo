class_name Spawner2D
extends Node2D

@onready var body := $Body as AnimatedSprite2D

@export var enemy_spawn_list: Array[EnemySpawnData]

##### Method Static #####
func _ready() -> void:
  body.play('default')
  init_enemies()

func _process(_delta: float) -> void:
  for enemy in enemy_spawn_list:
    var time_left = (Time.get_ticks_msec() - enemy.last_spawn_ms)/1000
    if time_left >= enemy.spawn_time:
      enemy.last_spawn_ms = Time.get_ticks_msec()
      var parent = get_parent()
      print('owner: ', parent.name)
      enemy.spawn(parent, global_position)

##### Method #####
func init_enemies():
  for enemy in enemy_spawn_list:
    enemy.last_spawn_ms = Time.get_ticks_msec()
