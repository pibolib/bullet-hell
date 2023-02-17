extends Node

var mouse_captured_status: bool = false

var user_config: Dictionary = {
	"MOUSE_SENSITIVITY": 150
}

func _ready():
	set_mouse_captured_status(true)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func set_mouse_captured_status(new_status: bool) -> void:
	if new_status:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured_status = new_status

func get_mouse_captured_status() -> bool:
	return mouse_captured_status

func get_mouse_sensitivity() -> float:
	return user_config.MOUSE_SENSITIVITY
