extends Enemy2D

@onready var shadow := $Shadow as AnimatedSprite2D

func hit(_hitter: Node2D):
	if health <= 0 && alive:
		shadow.play('dead')
		print('enemy ', self, ' is dead')
	print('enemy ', self, ': ', health, ' hp')
