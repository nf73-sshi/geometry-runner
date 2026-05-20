extends Pad

func _OnTrigger(player: Player):
	player._Jump(App.gravity_scale * 40.0)
