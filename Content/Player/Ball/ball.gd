extends Node3D

var parent : Player = null

func _ready() -> void:
	App._SetGravityScale(1.0)
	parent = get_parent()

func _physics_process(delta: float) -> void:
	if parent.need_to_jump:
		if parent._CanJump():
			parent.need_to_trigger_interact = false
			parent.need_to_jump = false		
			
			App._ReverseGravity()
			
	if parent._IsOnSurface():
		rotation_degrees.x += App.gravity_scale * delta * 500.0
	else:
		rotation_degrees.x -= App.gravity_scale * delta * 250.0
