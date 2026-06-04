extends Node3D

func _ready() -> void:
	rotation.z = randi_range(0, 1) * PI
