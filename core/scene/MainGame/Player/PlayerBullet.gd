extends Node2D
class_name PlayerBullet

# this scene should never be instantiated with a set position.
var angle: float = 0
var start_point := Vector2.ZERO
var target_point := Vector2.ZERO

func _ready():
	angle -= PI/2
	target_point = start_point + Vector2.from_angle(angle) * 1000
	#initializes tween for animation of values
	var tween: Tween = get_tree().create_tween()
	tween.parallel().tween_property($Visual, "width", 0, 2)
	tween.parallel().tween_property($Visual, "modulate", Color(0,0,0,0), 2)
	tween.tween_callback(queue_free)
	#update positioning of visual
	update_visual()
	#initiate positioning and rotation
	$CollisionDetector.position = start_point
	$CollisionDetector.rotation = angle
	$CollisionDetector.force_raycast_update()
	#it can be assumed that all collisions will be with areas only
	var collider: Area2D = $CollisionDetector.get_collider() 
	if collider != null:
		collider.on_bullet_collision(self)
		pass

func update_visual() -> void:
	$Visual.points = [start_point, target_point]

func set_start_point(pos: Vector2) -> Node:
	start_point = pos
	return self

func set_angle(ang: float) -> Node:
	angle = ang
	return self
