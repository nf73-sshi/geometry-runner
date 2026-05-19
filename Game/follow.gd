extends Camera3D

var start_dist : float = 0.0
var start_height : float = 0.0
var start_pos = Vector3.ZERO
var stop_follow : bool = false

func _ready() -> void:
	start_pos = global_position
	start_dist = abs(global_position.z - get_parent().get_node("Player").global_position.z)
	start_height = abs(global_position.y - get_parent().get_node("Player").global_position.y)
	pass
	
func _process(delta: float) -> void:
	if stop_follow:
		return

	var current_height = App.player.global_position.y - start_pos.y + 3.0
	if current_height < 0:
		current_height = 0
		
	global_position.z = App.player.global_position.z - start_dist
	global_position.y = start_pos.y + current_height

func _on_player_dead() -> void:
	stop_follow = true
