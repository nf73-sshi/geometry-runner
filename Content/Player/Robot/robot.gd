extends Node3D

var parent : Player = null

var resetted_anim : bool = false

func _ready() -> void:
	$Pivot/anim.play("RESET")
	parent = get_parent()
	App._SetGravityScale(1.0)
	
func _physics_process(delta: float) -> void:
	if parent._IsOnSurface():
		$Pivot/anim.play("walk")
		resetted_anim = false
	else:
		if resetted_anim == false:
			$Pivot/anim.play("RESET")
			resetted_anim = true
			return
			
		if parent.velocity.y * App.gravity_scale > 0.0:
			$Pivot/anim.play("jump")
		else:
			$Pivot/anim.play("fall")
			
	if not $HoldTimer.is_stopped():		
		if not parent.holding:
			$HoldTimer.stop()
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
