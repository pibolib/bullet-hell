extends EnemyPattern

const STANDARD_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletBasic.tscn")

#bullet attributes
const BULLET_SPEED: float = 130

func _ready():
	shoot_bullet_standard(get_angle_to_player(position), BULLET_SPEED, 0, STANDARD_SHOT)
	queue_free()
