extends Node

var players: Array[Entity2D] = []

var npcs: Array[Entity2D] = []

var enemies: Array[Entity2D] = []


##### Methods Players #####
func add_player(node: Entity2D):
	players.append(node)

func remove_player(node: Entity2D):
	players.erase(node)

##### Methods Enemies #####
func add_enemy(node: Entity2D):
	enemies.append(node)

func remove_enemy(node: Entity2D):
	enemies.erase(node)
