extends EnemyPattern

const SNIPER_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletSniper.tscn")

func _ready():
	shoot_bullet_sniper(SNIPER_SHOT)
