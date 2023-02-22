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
@export var start_delay = 0
@export var animation_player: AnimationPlayer
@export var model: CharacterModel

#other vars
var state := Status.INIT
var substate: int = 0
var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO
var friction: float = 0

func _ready():
	if model == null:
		model = $Model
	if animation_player == null:
		animation_player = $AnimationPlayer
	set_process(false)
	await get_tree().create_timer(start_delay, false).timeout
	init_state(Status.IDLE)

func _process(delta):
	position += velocity * delta
	velocity += acceleration * delta
	velocity -= velocity * (friction * delta)

func set_substate(new_substate: int) -> void:
	substate = new_substate

#super this
func init_state(new_state: Status, substate_flag: int = 0) -> void:
	state = new_state

func handle_state(state: Status, substate: int) -> void:
	pass

func handle_current_state() -> void: #version of handle_state for use in animations.
	handle_state(state, substate)

#override this with dodge logic if needed
func dodge(bullet: PlayerBullet) -> void:
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
