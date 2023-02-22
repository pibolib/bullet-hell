extends Node2D

func shoot_bullet_standard(angle: float, speed: float, bullet_type: PackedScene, additional_attributes: Dictionary = {}) -> void:
	var new_bullet = bullet_type.instantiate()
	new_bullet.set_angle(angle).set_speed(speed).set_additional_attributes(additional_attributes)
	add_sibling(new_bullet)

func shoot_bullet_laser(angle, bullet_type: PackedScene) -> void:
	var new_bullet = bullet_type.instantiate()
	#here goes code for setting stats of bullet
	add_sibling(new_bullet)
