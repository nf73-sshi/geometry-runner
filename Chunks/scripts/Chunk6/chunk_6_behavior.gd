extends Node3D

func _ready() -> void:
	var r1 = randi_range(0, 1)
	var r2 = randi_range(0, 1)
	
	var horizontal_rot = 0.0
	if r1 > 0.0:
		horizontal_rot = 180.0
	
	var vertical_rot = 0.0
	if r2 > 0.0:
		vertical_rot = 180.0
		
	rotation_degrees.y = horizontal_rot
	rotation_degrees.x = vertical_rot
	
