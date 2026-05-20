extends Orb

func _OnProcess(delta : float):
	rotate(rotate_dir, delta * 5)
	
func _OnTrigger(player: Player):
	player._Jump(15.0)
	App.gravity_scale *= -1.0
