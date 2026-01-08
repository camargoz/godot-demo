class_name Entity2D
extends CharacterBody2D

@export var health = 100
var alive = true

func _handle_ready():
  pass

func on_hit(_meta: DamageData):
  pass