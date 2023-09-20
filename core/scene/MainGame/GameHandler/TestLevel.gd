extends LevelEvent

const RIFLE_TYPE_A := preload("res://scene/MainGame/Stages/Stage1/RifleTypeA.tscn")
const SHOTGUN_TYPE_A := preload("res://scene/MainGame/Stages/Stage1/ShotgunTypeA.tscn")
const SNIPER_TYPE_A := preload("res://scene/MainGame/Stages/Stage1/SniperTypeA.tscn")
const DRONE_TYPE_A := preload("res://scene/MainGame/Stages/Stage1/DroneTypeA.tscn")
const STAGE_BGM := preload("res://asset/bgm/stage1.ogg")
const BOSS_BGM := preload("res://asset/bgm/boss1.ogg")

func define_level():
	play_bgm(STAGE_BGM)
	
	background_scroll(50, 3)
	time_wait(3)
	background_scroll(60, 1.5)
	for i in 5:
		spawn_entity(DRONE_TYPE_A, Vector2(0, 100))
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
		for j in 2:
			spawn_entity(SHOTGUN_TYPE_A, Vector2(50+100*j, -20))
		time_wait(0.5)
	background_scroll(200, 1.5)
	for i in 3:
		for j in 2:
			spawn_entity(SHOTGUN_TYPE_A, Vector2(50+100*j, -20))
		time_wait(0.3)
	time_wait(4)
	background_scroll(250, 4)
	for i in 3:
		spawn_entity(RIFLE_TYPE_A, Vector2(0,80+25*i), {"entry_direction":"Left"})
		spawn_entity(RIFLE_TYPE_A, Vector2(0,120+25*i), {"entry_direction":"Left"})
		spawn_entity(RIFLE_TYPE_A, Vector2(0,160+25*i), {"entry_direction":"Left"})
		time_wait(0.75)
	time_wait(3)
	for i in 3:
		spawn_entity(RIFLE_TYPE_A, Vector2(300,60+25*i), {"entry_direction":"Right"})
		spawn_entity(RIFLE_TYPE_A, Vector2(300,100+25*i), {"entry_direction":"Right"})
		spawn_entity(RIFLE_TYPE_A, Vector2(300,140+25*i), {"entry_direction":"Right"})
		time_wait(0.75)
	time_wait(6)
	play_bgm(BOSS_BGM)
	for i in 4:
		spawn_entity(DRONE_TYPE_A, Vector2(0,40))
		time_wait(0.2)
		spawn_entity(RIFLE_TYPE_A, Vector2(300, 120), {"entry_direction":"Right"})
		time_wait(0.2)
	time_wait(1)
	for i in 5:
		spawn_entity(DRONE_TYPE_A, Vector2(300, 80), {"entry_direction":"Right"})
		time_wait(0.25)
		spawn_entity(RIFLE_TYPE_A, Vector2(0, 160))
		time_wait(0.25)
	time_wait(1)
	for i in 6:
		spawn_entity(DRONE_TYPE_A, Vector2(0, 120))
		time_wait(0.3)
		spawn_entity(RIFLE_TYPE_A, Vector2(300, 200), {"entry_direction":"Right"})
		time_wait(0.3)
	time_wait(1)
	for i in 7:
		spawn_entity(DRONE_TYPE_A, Vector2(300, 160), {"entry_direction":"Right"})
		time_wait(0.35)
		spawn_entity(RIFLE_TYPE_A, Vector2(0, 240))
		time_wait(0.35)
	time_wait(1)
	level_end()
