extends Pad

func _OnTrigger(player: Player):
	player._Jump(20.0)
	App.gravity_scale *= -1.0
