extends Enemy

class_name PistolTypeA

var patterns :=[preload("res://scene/MainGame/Stages/Stage1/PistolTypeA.tscn")]

func set_stats() -> void:
	hp=1
	dodges=0
	score=200
	attribute_defaults={
		"entry_direction":"left",
		"movement_trend":"Up",
		"attack_type":"Aimed",
		"attack_barrage_delay":0.15,
		"attack_count":3,
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
			match attributes.movement_trend: #test this
				"Up":
					set_acceleration(Vector2(0, -10))
				"Down":
					set_acceleration(Vector2(0, 10))
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
			#score bit goes here
			model.set_animation("Die")
			state_timer.start(1.5)
	



