extends Node3D

var parent : Player = null

func _ready() -> void:
	parent = get_parent()

func _physics_process(delta: float) -> void:
	if parent.need_to_jump:
		if parent._CanJump():
			parent.need_to_trigger_interact = false
			
			if not parent.holding:
				parent.need_to_jump = false		
				
			parent._Jump(App.player_jump_impulse)

	if not parent._IsOnSurface():
		rotation_degrees.x += App.gravity_scale * delta * 300.0
	else:
		rotation_degrees.x = round(rotation_degrees.x / 90.0) * 90.0
