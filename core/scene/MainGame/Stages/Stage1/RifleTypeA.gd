extends Enemy
class_name RifleTypeA
#
#@export_enum("Left","Right") var entry_direction: int = 0
#@export_enum("Up","Down") var movement_trend: int = 0
#@export_enum("Aimed", "Vertical") var attack_type: int = 0
#@export_range(0.3, 1.0, 0.1) var attack_barrage_delay: float = 0.5
#@export_range(1, 10, 1) var attack_count: int = 3
#@export var movement_speed: float = 80
var patterns := [preload("res://scene/MainGame/Stages/Stage1/RifleTypeAPatternA.tscn")]

func set_stats() -> void:
	hp = 1
	dodges = 0
	score = 300
	attribute_defaults = {
		"entry_direction": "Left", #valid keys: Left, Right
		"movement_trend": "Up", #valid keys: Up, Down
		"attack_type": "Aimed", #valid keys: Aimed, Vertical (unimplemented)
		"attack_barrage_delay": 0.5, #range: 0.1 - 1.0
		"attack_count": 3, #range: 1 - 10
		"movement_speed": 80 #any value
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
					fire_pattern(patterns[0])
					state_timer.start(attributes.attack_barrage_delay)
				2:
					model.set_animation("Idle")
		Status.DIE:
			#score bit goes here
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
