extends EnemyPattern

const STANDARD_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletBasic.tscn")

# bullet attributes
const BULLET_SPEED: float = 130
const BULLET_POSITION_OFFSET: float = 10

func _ready():
	for i in range(8):
		var angle = i * 45  # Calculate the angle for each bullet

		# Shoot the bullet at the calculated angle
		shoot_bullet_standard(angle, BULLET_SPEED, BULLET_POSITION_OFFSET, STANDARD_SHOT)

	queue_free()  # Queue the enemy for removal
