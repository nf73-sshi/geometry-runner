class_name Orb

extends Node3D

@export var multi_trigger : bool = false
var used : bool = false
var can_be_used = false

#bonus
var rotate_dir = Vector3(1, 1, 1).normalized()

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
	if not can_be_used:
		return
	
	var current = App.player
	if current != null and current.need_to_jump:
		_Trigger(current)

func _on_area_body_entered(body: Node3D) -> void:
	can_be_used = true

func _on_area_body_exited(body: Node3D) -> void:
	can_be_used = false
