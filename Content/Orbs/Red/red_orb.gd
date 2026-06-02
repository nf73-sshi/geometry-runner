extends Orb

func _OnProcess(delta : float):
	rotate(rotate_dir, delta * 5)
	
func _OnTrigger(player: Player):
	player._Jump(45.0)
