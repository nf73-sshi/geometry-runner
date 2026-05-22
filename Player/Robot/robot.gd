extends Node3D

var parent : Player = null

func _ready() -> void:
	parent = get_parent()
	App._SetGravityScale(1.0)
	
func _physics_process(delta: float) -> void:
	
	if not $HoldTimer.is_stopped():		
		if not parent.holding:
			parent.need_to_jump = false		
		else:
			parent._Jump(App.player_jump_impulse * 0.6)
			
	if parent.need_to_jump:
		if parent._CanJump():
			$HoldTimer.start()
			parent.need_to_trigger_interact = false
			
	if App.gravity_scale > 0.0:
		rotation_degrees.z = 0.0
	else:
		rotation_degrees.z = 180.0

func _on_hold_timer_timeout() -> void:
	parent.holding = false
