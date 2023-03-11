extends LevelEvent

const RIFLE_TYPE_A = preload("res://scene/MainGame/Stages/Stage1/RifleTypeA.tscn")
const SHOTGUN_TYPE_A = preload("res://scene/MainGame/Stages/Stage1/ShotgunTypeA.tscn")

func define_level():
	background_scroll(50, 3)
	time_wait(3)
	background_scroll(100, 2.5)
	for i in 25:
		spawn_entity(RIFLE_TYPE_A, Vector2(0, 100))
		time_wait(0.1)
	background_scroll(150, 4.5)
	for i in 30:
		spawn_entity(SHOTGUN_TYPE_A, Vector2(300, 100) )
		time_wait(0.15)
	for j in 3:
		for i in 10:
			spawn_entity(SHOTGUN_TYPE_A, Vector2(30*i, 0))
		time_wait(1)
	level_end()
