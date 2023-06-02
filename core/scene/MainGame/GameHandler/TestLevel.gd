extends LevelEvent

const RIFLE_TYPE_A := preload("res://scene/MainGame/Stages/Stage1/RifleTypeA.tscn")
const SHOTGUN_TYPE_A := preload("res://scene/MainGame/Stages/Stage1/ShotgunTypeA.tscn")
const SNIPER_TYPE_A := preload("res://scene/MainGame/Stages/Stage1/SniperTypeA.tscn")
const STAGE_BGM := preload("res://asset/bgm/stage1.ogg")
const BOSS_BGM := preload("res://asset/bgm/boss1.ogg")

func define_level():
	play_bgm(STAGE_BGM)
	
	time_wait(5)
	background_scroll(50, 3)
	time_wait(3)
	background_scroll(60, 1.5)
	for i in 5:
		spawn_entity(RIFLE_TYPE_A, Vector2(0, 100))
		time_wait(0.3)
	background_scroll(100, 1)
	time_wait(1)
	background_scroll(110, 1.5)
	for i in 5:
		spawn_entity(RIFLE_TYPE_A, Vector2(300,120), {"entry_direction":"Right"})
		time_wait(0.3)
	background_scroll(150, 2)
	time_wait(2)
	background_scroll(160, 1.5)
	for i in 3:
		for j in 3:
			spawn_entity(SHOTGUN_TYPE_A, Vector2(50+100*j, -20))
		time_wait(0.5)
	background_scroll(200, 1.5)
	for i in 5:
		for j in 3:
			spawn_entity(SHOTGUN_TYPE_A, Vector2(50+100*j, -20))
		time_wait(0.3)
	time_wait(2)
	background_scroll(250, 2)
	for i in 5:
		spawn_entity(SNIPER_TYPE_A, Vector2(0, 160), {"movement_speed":120})
		spawn_entity(SNIPER_TYPE_A, Vector2(300,180), {"entry_direction":"Right"})
		time_wait(0.4)
	play_bgm(BOSS_BGM)
	level_end()
