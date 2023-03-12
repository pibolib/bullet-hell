extends EnemyPattern

const STANDARD_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletBasic.tscn")

#bullet attributes
const BULLET_SPEED: float = 130
const BULLET_POSITION_OFFSET: float = 10

func _ready():
	
	for i in 3:
		shoot_bullet_standard(get_angle_to_player(position), BULLET_SPEED, -i * BULLET_POSITION_OFFSET, STANDARD_SHOT)
	queue_free()
