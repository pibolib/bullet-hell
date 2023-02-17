extends CharacterModel

var aim_dir: float = 0.0

func _dynamic_animation(_animation_time: float):
	match current_animation:
		_:
			%Arm.rotation = aim_dir

func get_firing_position() -> Vector2:
	return %BulletSpawn.global_position
