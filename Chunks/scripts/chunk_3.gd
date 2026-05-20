extends Node3D

func _ready() -> void:
	var offset : float = 3.0
	var rdm_pos = Vector3(randi_range(-1, 1), randi_range(-1, 1), randi_range(-1, 1))
	$YellowOrb.position.z += offset * rdm_pos.x
	$YellowOrb2.position.z += offset * rdm_pos.y
	$YellowOrb3.position.z += offset * rdm_pos.z
