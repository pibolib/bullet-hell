extends Enemy
class_name SniperTypeA

var patterns := [preload("res://scene/MainGame/Stages/Stage1/SniperTypeAPatternA.tscn")]

func set_stats() -> void:
	hp = 1
	dodges = 1
	score = 1000
	attribute_defaults = {
		"entry_direction": "Left", #valid keys: Left, Right, Up, Down
		"movement_speed": 200, #TBD
		"burst_count": 3, #range: 1 - 4
		"shot_count": 1, #range: 1 - 4
		"burst_delay": 2.0 #range: 0.1 - 2.0
	}

func init_state(new_state: Status, new_substate: int = 0) -> void:
	super(new_state, new_substate)
	match new_state:
		Status.IDLE:
			match attributes.entry_direction:
				"Left":
					set_velocity(Vector2(attributes.movement_speed, 0))
					set_acceleration(Vector2(-attributes.movement_speed * 2, 0))
				"Right":
					set_velocity(Vector2(-attributes.movement_speed, 0))
					set_acceleration(Vector2(attributes.movement_speed * 2, 0))
				"Up":
					set_velocity(Vector2(0, attributes.movement_speed))
					set_acceleration(Vector2(0, -attributes.movement_speed * 2))
				"Down":
					set_velocity(Vector2(0, -attributes.movement_speed))
					set_acceleration(Vector2(0, attributes.movement_speed * 2))
			state_timer.start(0.5)
		Status.ACTIVE:
			match new_substate:
				0:
					set_velocity(Vector2(0, 0))
					set_acceleration(Vector2(0, 0))
					model.set_animation("Fire")
					state_timer.start(0.50)
				1:
					model.set_animation("Fire")
					model.queue_animation("Ready")
					fire_pattern(patterns[0])
					model.set_animation("Idle")
					state_timer.start(0.25)
				2:
					model.set_animation("Ready")
					state_timer.start(attributes.burst_delay)
				3:
					model.set_animation("Idle")
					match attributes.entry_direction:
						"Left":
							set_acceleration(Vector2(-attributes.movement_speed * 2, 0))
						"Right":
							set_acceleration(Vector2(attributes.movement_speed * 2, 0))
						"Up":
							set_acceleration(Vector2(0, -attributes.movement_speed * 2))
						"Down":
							set_acceleration(Vector2(0, attributes.movement_speed * 2))
		Status.DIE:
			#score here
			model.set_animation("Die")
			state_timer.start(1.5)

func handle_state(current_state: Status, current_substate: int = 0) -> void:
	match current_state:
		Status.IDLE:
			init_state(Status.ACTIVE, 0)
		Status.ACTIVE:
			match current_substate:
				0:
					init_state(Status.ACTIVE, 1)
				1:
					attributes.shot_count -= 1
					if attributes.shot_count == 0:
						init_state(Status.ACTIVE, 2)
					else:
						init_state(Status.ACTIVE, 1)
				2:
					attributes.burst_count -= 1
					if attributes.burst_count > 0:
						attributes.shot_count = attribute_defaults.shot_count
						init_state(Status.ACTIVE, 1)
					else:
						init_state(Status.ACTIVE, 3)
		Status.DIE:
			queue_free()
