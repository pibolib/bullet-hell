extends Enemy

class_name DroneTypeA

var patterns :=[preload("res://scene/MainGame/Stages/Stage1/DroneTypeAPatternA.tscn")]

func set_stats() -> void:
	hp=1
	dodges=0
	score=400
	attribute_defaults={
		"entry_direction":"Left",
		"movement_trend":"Up",
		"attack_type":"Aimed",
		"attack_barrage_delay":0.25,
		"attack_count":1,
		"movement_speed":80
	}
	
	
func init_state(new_state: Status, new_substate: int = 0) -> void:
	super(new_state, new_substate)
	match new_state:
		Status.IDLE:
			match attributes.entry_direction:
				"Left":
					set_velocity(Vector2(attributes.movement_speed, 0))
				"Right":
					set_velocity(Vector2(-attributes.movement_speed, 0))
			match attributes.movement_trend: 
				"Up":
					set_acceleration(Vector2(0, -10))
				"Down":
					set_acceleration(Vector2(0 , 10))
			model.set_animation("Idle")
			state_timer.start(0.5)
		Status.ACTIVE:
			match new_substate:
				0:
					model.set_animation("Ready")
					state_timer.start(0.25)
				1:
					model.set_animation("Fire")
					model.queue_animation("Ready")
					var pattern = create_pattern(patterns[0])
					fire_pattern(pattern)
					state_timer.start(attributes.attack_barrage_delay)
				2:
					model.set_animation("Idle")
		Status.DIE:
			GameVariables.score += score
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
					attributes.attack_count -= 1
					if attributes.attack_count == 0:
						init_state(Status.ACTIVE, 2)
					else:
						init_state(Status.ACTIVE, 1)
		Status.DIE:
			queue_free() 
