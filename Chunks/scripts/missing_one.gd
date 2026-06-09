extends Node3D

func _ready() -> void:
	if get_child_count() <= 0:
		return
		
	var rdm = randi_range(0, get_child_count() - 1)
	get_children()[rdm].queue_free()
