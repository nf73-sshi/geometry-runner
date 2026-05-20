class_name Pad
extends Node3D

@export var multi_trigger : bool = false
var used : bool = false

func _OnProcess(delta : float):
	pass
	
func _OnTrigger(player: Player):
	pass

func _Trigger(player):
	if used:
		return
		
	if not multi_trigger:
		used = true
		player.need_to_jump = false
		_OnTrigger(player)

func _physics_process(delta: float) -> void:
	_OnProcess(delta)

func _on_area_body_entered(body: Node3D) -> void:
	var current = App.player
	if current != null:
		_Trigger(current)
