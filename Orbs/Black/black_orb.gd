extends Orb

func _OnProcess(delta : float):
	rotate(rotate_dir, delta * 5)
	
func _OnTrigger(player: Player):
	player.velocity.y = -App.gravity_scale * App.player_max_velocity_y
