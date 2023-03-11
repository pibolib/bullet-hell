extends EnemyPattern

const STANDARD_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletBasic.tscn")

#bullet attributes
const BULLET_SPEED: float = 90
const BULLET_SPREAD_DEG: float = 20
const BULLET_POSITION_OFFSET: float = 0

func _ready():
	shoot_bullet_standard(get_angle_to_player(position), BULLET_SPEED, BULLET_POSITION_OFFSET, STANDARD_SHOT)
	shoot_bullet_standard(get_angle_to_player(position) + BULLET_SPREAD_DEG, BULLET_SPEED, BULLET_POSITION_OFFSET, STANDARD_SHOT)
	shoot_bullet_standard(get_angle_to_player(position) - BULLET_SPREAD_DEG, BULLET_SPEED, BULLET_POSITION_OFFSET, STANDARD_SHOT)
	queue_free()
