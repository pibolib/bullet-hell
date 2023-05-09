extends Control

var current_score : int = 0

func _process(delta):
	current_score = GameVariables.score
	$TopLeft/Score.text = "Score: " + str(current_score)

func update_score() -> void:
	pass

func update_hp(hp : int) -> void:
	pass

func update_bullets(bullets : int) -> void:
	pass
