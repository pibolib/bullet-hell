extends EnemyPattern

const SNIPER_SHOT: PackedScene = preload("res://scene/MainGame/Enemy/EnemyBulletSniper.tscn")

func _ready():
	shoot_bullet_sniper(0, SNIPER_SHOT) #replace this 0 with the proper angle for the shot
