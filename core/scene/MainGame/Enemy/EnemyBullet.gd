extends Area2D
class_name EnemyBullet

@export var angle: float = 0.0
@export var speed: float = 0.0
@export var color := Color.BLUE
var velocity := Vector2.ZERO
var attributes: Dictionary = {
	#angular_accel: {speed: number, angle: number}
	#linear_accel: {speed: number}
	#despawn_time: number
}

func _ready():
	velocity = Vector2.from_angle(angle) * speed
	if attributes.has("despawn_time"):
		await_despawn(get_tree().create_timer(attributes.despawn_time, false))

func _process(delta):
	position += velocity * delta
	if attributes.has("angular_accel"):
		velocity += Vector2.from_angle(attributes.angular_accel.angle) * attributes.angular_accel.speed
	if attributes.has("linear_accel"):
		velocity += Vector2.from_angle(angle) * attributes.linear_accel.speed
	if is_out_of_bounds():
		queue_free()

func is_out_of_bounds() -> bool:
	if position.x < 0 - GameVariables.despawn_bounds or position.x > GameVariables.screen_size.x + GameVariables.despawn_bounds or position.y < 0 - GameVariables.despawn_bounds or position.y > GameVariables.screen_size.y + GameVariables.despawn_bounds:
		return true
	return false

func await_despawn(timer: SceneTreeTimer) -> void:
	await timer.timeout
	queue_free()

func set_angle(new_angle: float) -> EnemyBullet:
	angle = new_angle
	return self

func set_speed(new_speed: float) -> EnemyBullet:
	speed = new_speed
	return self

func set_additional_attributes(additional_attributes: Dictionary) -> EnemyBullet:
	attributes = additional_attributes
	return self
