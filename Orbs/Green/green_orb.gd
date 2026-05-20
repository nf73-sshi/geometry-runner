extends Orb

func _OnProcess(delta : float):
	rotate(rotate_dir, delta * 5)
	
func _OnTrigger(player: Player):
	App.gravity_scale *= -1.0
	player._Jump(clampf(abs(player.velocity.y) + 10.0, 0.0, App.player_max_velocity_y))
