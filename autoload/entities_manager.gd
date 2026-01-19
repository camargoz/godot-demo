extends Node

var players: Array[Entity2D] = []

var npcs: Array[Entity2D] = []

var enemies: Array[Entity2D] = []

var objectives: Array[Entity2D] = []

##### Methods #####
func add_entity(node: Entity2D, group_name: String):
	if group_name in self:
		self[group_name].append(node)

func remove_entity(node: Entity2D, group_name: String):
	if group_name in self:
		self[group_name].erase(node)
