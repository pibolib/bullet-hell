extends EnemyPattern

var standard_shot: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletBasic.tscn")

func _ready():
	shoot_bullet_standard(get_angle_to_player(position), 130, 10, standard_shot)
	shoot_bullet_standard(get_angle_to_player(position) + 20, 130, 10, standard_shot)
	shoot_bullet_standard(get_angle_to_player(position) - 20, 130, 10, standard_shot)
	queue_free()
