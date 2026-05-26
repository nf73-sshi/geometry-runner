extends Chunk

func _ready() -> void:
	_Start()
	
	var offset : float = 3.0
	var rdm_pos = Vector3(randi_range(-1, 1), randi_range(-1, 1), randi_range(-1, 1))
	$YellowOrb.position.x += offset * rdm_pos.x
	$YellowOrb2.position.x += offset * rdm_pos.y
	$YellowOrb3.position.x += offset * rdm_pos.z
