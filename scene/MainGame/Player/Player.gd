extends Area2D
class_name Player

const PLAYER_SPEED: float = 75
const PLAYER_SPEED_FOCUS_MODIFIER: float = 0.5
var velocity := Vector2.ZERO
var movement_angle: float = 0.0
var focused: bool = false
var aim_dir: float = 0.0 #temporary value

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion and Global.get_mouse_captured_status():
		aim_dir += event.relative.x / Global.get_mouse_sensitivity()
		aim_dir = clamp(aim_dir, -PI/2, PI/2) # clamp gun angle between two values

func _process(delta):
	#handle input detection (properly handles multidirectional movement)
	var is_moving = false
	if Input.is_action_pressed("ingame_move_up"):
		movement_angle = 3*TAU/4
		is_moving = true
	elif Input.is_action_pressed("ingame_move_down"):
		movement_angle = TAU/4
		is_moving = true
	if Input.is_action_pressed("ingame_move_left"):
		if is_moving:
			movement_angle = lerp_angle(movement_angle, TAU/2, 0.5)
		else:
			movement_angle = TAU/2
		is_moving = true
	elif Input.is_action_pressed("ingame_move_right"):
		if is_moving:
			movement_angle = lerp_angle(movement_angle, 0, 0.5)
		else:
			movement_angle = 0
		is_moving = true
	
	#creates the velocity vector from the angle of movement, player speed constant, boolean control of movement, and a multiplier based on the focus status
	velocity = Vector2.from_angle(movement_angle) * PLAYER_SPEED * int(is_moving)# * (PLAYER_SPEED_FOCUS_MODIFIER * int(focused))
	velocity = round(velocity)
	position += velocity * delta
	
	#end of logic, update model
	update_model()

func update_model():
	%Model.aim_dir = aim_dir
