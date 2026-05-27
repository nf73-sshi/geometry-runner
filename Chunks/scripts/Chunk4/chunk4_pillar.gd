extends Node3D

func _ready() -> void:
	var rdm = randi_range(-1, 1)
	position.x += rdm * 3.0
