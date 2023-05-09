extends Area2D
class_name Enemy

enum Status {
	INIT,
	IDLE,
	ACTIVE,
	DIE
}

#general enemy exports
@export var hp: int = 1
@export var dodges: int = 0
@export var score: int = 0
@export var start_delay = 0
@export var model: CharacterModel

#other vars
var state := Status.INIT
var substate: int = 0
var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO
var friction: float = 0
var attributes: Dictionary = {}
var attribute_defaults: Dictionary = {}
var uses_control_tag: bool = false
var tag_name = ""
@onready var state_timer := Timer.new()

func _ready():
	add_child(state_timer)
	state_timer.connect("timeout", handle_current_state)
	state_timer.one_shot = true
	set_stats()
	attributes.merge(attribute_defaults, false)
	set_process(false)
	await get_tree().create_timer(start_delay, false).timeout
	set_process(true)
	init_state(Status.IDLE)

func _process(delta):
	position += velocity * delta
	velocity += acceleration * delta
	#velocity -= velocity * (friction * delta)
	if is_out_of_bounds():
		queue_free()
	tick(delta)

func is_out_of_bounds() -> bool:
	if position.x < 0 - GameVariables.despawn_bounds or position.x > GameVariables.screen_size.x + GameVariables.despawn_bounds or position.y < 0 - GameVariables.despawn_bounds or position.y > GameVariables.screen_size.y + GameVariables.despawn_bounds:
		return true
	return false

func set_substate(new_substate: int) -> void:
	substate = new_substate

#override this
func set_stats() -> void:
	pass
	
#override and super this
func init_state(new_state: Status, new_substate: int = 0) -> void:
	state = new_state
	substate = new_substate
	match state:
		Status.DIE:
			queue_free()

#override this
func handle_state(_current_state: Status, _current_substate: int) -> void:
	pass

func handle_current_state() -> void: #version of handle_state for use in animations.
	handle_state(state, substate)

#override this with dodge logic if needed
func dodge(_bullet: PlayerBullet) -> void:
	dodges -= 1
	# add code to cause dodge movement here

#override this, functions just like process(delta)
func tick(_delta) -> void:
	pass
	

func on_bullet_collision(bullet: PlayerBullet) -> void:
	if dodges > 0:
		dodge(bullet)
	else:
		take_damage()

func take_damage() -> void:
	hp -= 1
	if hp <= 0:
		init_state(Status.DIE)
	#other things that happen when damage is taken goes here

func set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity
	pass

func set_velocity_magnitude(new_magnitude: float) -> void:
	velocity = velocity.normalized() * new_magnitude

func set_velocity_direction(new_direction_radians: float) -> void:
	var current_magnitude: float = velocity.length()
	velocity = Vector2.from_angle(new_direction_radians) * current_magnitude
	
func set_acceleration(new_acceleration: Vector2) -> void:
	acceleration = new_acceleration

func set_acceleration_magnitude(new_magnitude: float) -> void:
	acceleration = acceleration.normalized() * new_magnitude

func set_acceleration_direction(new_direction_radians: float) -> void:
	var current_magnitude: float = acceleration.length()
	acceleration = Vector2.from_angle(new_direction_radians) * current_magnitude

func create_pattern(pattern: PackedScene) -> Node:
	var new_pattern := pattern.instantiate()
	new_pattern.position = position
	return new_pattern

func fire_pattern(pattern: Node) -> void:
	add_sibling(pattern)

func get_angle_to_player(start_position) -> float:
	return start_position.angle_to_point(GameVariables.player_position)

func _exit_tree():
	if uses_control_tag:
		get_parent().control_tag.increment_current_value()
	if tag_name != "":
		for tag in get_parent().active_tags:
			if tag.name == tag_name:
				tag.increment_current_value()
				break
