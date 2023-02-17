extends CharacterModel

var aim_dir: float = 0.0

func _dynamic_animation(_animation_time: float):
	match current_animation:
		_:
			%Arm.rotation = aim_dir
