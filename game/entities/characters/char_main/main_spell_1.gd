extends ProjectileRocket

@onready var particles := $Particles as GPUParticles2D

func _process(_delta: float):
	self.update_pos(_delta)
	if self.timer.time_left <= 0.2:
		particles.emitting = false
