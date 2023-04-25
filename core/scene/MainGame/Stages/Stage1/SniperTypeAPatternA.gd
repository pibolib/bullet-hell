extends EnemyPattern

const SNIPER_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletSniper.tscn")
var angle : float = 0

func _ready():
	shoot_bullet_sniper(angle, SNIPER_SHOT)
