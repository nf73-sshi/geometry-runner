extends Node3D

func _ready() -> void:
	position.x += randi_range(-1, 1) * 3.0
	position.y += randi_range(-1, 1) * 3.0
	pass
func _process(delta: float) -> void:
	pass
