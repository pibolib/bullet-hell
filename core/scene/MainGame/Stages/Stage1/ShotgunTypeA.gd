extends Enemy
class_name ShotgunTypeA

var patterns := [preload("res://scene/MainGame/Stages/Stage1/ShotgunTypeAPatternA.tscn")]

func set_stats() -> void:
	hp = 1
	dodges = 0
	score = 500
	attribute_defaults = {
		"attack_barrage_delay": 1.0, #range: 0.1 - 1.0
		"movement_speed": 120, #any value
		"repel_range": 100 #some value
	}

func init_state(new_state: Status, new_substate: int = 0) -> void:
	super(new_state, new_substate)
	# this should be moved to a more suitable position (in the IDLE state)
	$RepelRange/CollisionShape2D.shape.radius = attributes.repel_range
	match new_state:
		Status.IDLE:
			set_velocity(Vector2.from_angle(get_angle_to_player(position)) * attributes.movement_speed)
			model.set_animation("Ready")
			await $RepelRange.area_entered
			init_state(Status.ACTIVE, 0)
		Status.ACTIVE:
			match new_substate:
				0:
					state_timer.start(0.15)
				1:
					set_acceleration(Vector2(0, -150))
					model.set_animation("Idle")
		Status.DIE:
			#score here
			model.set_animation("Die")
			state_timer.start(1.5)

func handle_state(current_state: Status, current_substate: int = 0) -> void:
	match current_state:
		Status.ACTIVE:
			match current_substate:
				0:
					model.set_animation("Fire")
					var pattern = create_pattern(patterns[0])
					fire_pattern(pattern)
					init_state(Status.ACTIVE, 1)
		Status.DIE:
			queue_free()
