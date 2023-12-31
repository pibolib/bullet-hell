extends Node2D
class_name EnemyPattern

func shoot_bullet_standard(angle_degrees: float, speed: float, position_offset: float, bullet_type: PackedScene, additional_attributes: Dictionary = {}) -> void:
	var new_bullet = bullet_type.instantiate()
	new_bullet.position = global_position
	new_bullet.set_angle(deg_to_rad(angle_degrees)).set_speed(speed).set_additional_attributes(additional_attributes)
	new_bullet.position += Vector2.from_angle(deg_to_rad(angle_degrees)) * position_offset
	add_sibling(new_bullet)

func shoot_bullet_laser(_angle, bullet_type: PackedScene) -> void:
	var new_bullet = bullet_type.instantiate()
	#new_bullet.position = global_position
	#here goes code for setting stats of bullet
	add_sibling(new_bullet)

func shoot_bullet_sniper(angle: float, bullet_type: PackedScene) -> void:
	var new_bullet = bullet_type.instantiate()
	new_bullet.start_point = global_position
	new_bullet.angle = angle
	#new_bullet.target_point = GameVariables.player_position
	add_sibling(new_bullet)

func get_angle_to_player(start_position: Vector2) -> float:
	return rad_to_deg(start_position.angle_to_point(GameVariables.player_position))
