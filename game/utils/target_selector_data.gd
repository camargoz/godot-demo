class_name TargetSelectorData

var _list_targets: Array[String] = []
var _search_interval: float = 0.5
var _timer: float = 0.0
var _target: Entity2D

func _init(
	targets: Array[String],
	interval: float = 0.5
):
	self._list_targets = targets
	self._search_interval = interval

func update(delta: float, origin: Vector2):
	self._timer -= delta
	if _timer > 0:
		return
	self._timer = self._search_interval
	self._target = self._find_target(origin)

func get_target():
	if self._target and self._target.alive:
		return self._target
	self._target = null
	return self._target

func get_distance_target(origin: Vector2) -> float:
	if get_target():
		return (self._target.global_position - origin).length()
	return 0.0

##### Private Methods #####
func _find_target(origin: Vector2) -> Entity2D:
	var best: Entity2D = null
	var best_dist := INF
	
	var list_to_search: Array[Entity2D] = []
	for list_name in self._list_targets:
		list_to_search.append_array(self._get_entity_list(list_name))
	
	for entity in list_to_search:
		var distance = origin.distance_squared_to(entity.global_position)
		if distance < best_dist:
			best_dist = distance
			best = entity
	
	return best

func _get_entity_list(list_name: String) -> Array[Entity2D]:
	if list_name in EntitiesManager:
		return EntitiesManager[list_name]
	return []
