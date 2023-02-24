extends EnemyPattern

var standard_shot: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletBasic.tscn")

func _ready():
	for i in 3:
		shoot_bullet_standard(get_angle_to_player(position), 130, -i * 10, standard_shot)
	queue_free()
