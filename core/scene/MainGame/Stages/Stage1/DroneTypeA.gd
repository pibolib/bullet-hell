

extends Enemy

class_name DroneTypeA

var patterns :=[preload("res://scene/MainGame/Stages/Stage1/DroneTypeA.tscn")]

func set_stats() -> void:
	hp=1
	dodges=0
	score=200
	attribute_defaults={
		"entry_direction":"Left",
		"movement_trend":"Up",
		"attack_type":"Aimed",
		"attack_barrage_delay":0.15,
		"attack_count":3,
		"movement_speed":80
	}
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
