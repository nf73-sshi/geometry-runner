extends Node3D

var parent : Player = null

func _ready() -> void:
	App._SetGravityScale(0.5)
	parent = get_parent()

func _physics_process(delta: float) -> void:
	if parent.need_to_jump:
		parent.need_to_jump = false		
		parent._Jump(34.0)

	if App.gravity_scale > 0.0:
		rotation_degrees.z = 0.0
	else:
		rotation_degrees.z = 180.0
