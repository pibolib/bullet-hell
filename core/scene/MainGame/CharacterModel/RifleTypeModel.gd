extends CharacterModel
class_name RifleTypeModel

var aim_direction: float = 0.0

func _dynamic_animation(_animation_time: float) -> void:
	match get_animation():
		"Ready", "Fire":
			aim_direction = get_angle_to_player(position)
			%GunAimed.scale.x = 1 - sin(wrapf(aim_direction,0,PI))/4
			%GunAimed.rotation = aim_direction
