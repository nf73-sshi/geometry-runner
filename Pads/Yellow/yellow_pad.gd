extends "res://Pads/pad.gd"

func _OnTrigger(player: Player):
	player._Jump(40)
