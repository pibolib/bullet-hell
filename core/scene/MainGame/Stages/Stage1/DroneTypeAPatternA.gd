extends EnemyPattern

const STANDARD_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletBasic.tscn")

# bullet attributes
const BULLET_SPEED: float = 130
const BULLET_POSITION_OFFSET: float = 10

func _ready():
	for i in range(8):
		var angle = i * 45
		shoot_bullet_standard(angle, BULLET_SPEED, BULLET_POSITION_OFFSET, STANDARD_SHOT)

	queue_free() 
