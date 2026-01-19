class_name ProjectileData

var _next_cast_time: float = 0.0
var _cooldown_time_s: float = 0.0
var _handle_cast: Callable

func _init(
	cooldown: float,
	handle_cast: Callable
):
	self._cooldown_time_s = cooldown
	self._handle_cast = handle_cast
	self._next_cast_time = -(cooldown*1000)

func get_next_cast_time():
	return self._next_cast_time / 1000.0

func get_cooldown():
	return self._cooldown_time_s

func is_already() -> bool:
	var time_left = Time.get_ticks_msec() - self._next_cast_time
	return (time_left/1000) > self._cooldown_time_s

func cast():
	if self.is_already():
		self._handle_cast.call()
		self._next_cast_time = Time.get_ticks_msec()
