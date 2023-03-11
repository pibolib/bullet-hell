extends Node2D
class_name CharacterModel

#this class defines a general class for all character models.

@export var animation_controller: AnimationPlayer
var default_animation := "Idle"

var current_animation := ""

#unless absolutely necessary, do not override
func _ready():
	set_animation(default_animation)

#unless absolutely necessary, do not override
func _process(_delta):
	var current_animation_time = animation_controller.current_animation_position
	_dynamic_animation(current_animation_time)

#this should be the only function that needs to be overrided. pass in special animation arguments through
func _dynamic_animation(_animation_time: float) -> void:
	pass

#various getters/setters for values.
func set_animation(new_animation_name: String) -> void:
	current_animation = new_animation_name
	animation_controller.play(new_animation_name)

func get_animation() -> String:
	return animation_controller.current_animation

func queue_animation(animation_name: String) -> void:
	animation_controller.queue(animation_name)

func get_angle_to_player(start_position: Vector2) -> float:
	return start_position.angle_to_point(GameVariables.player_position)-PI/2
