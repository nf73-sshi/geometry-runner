extends Node3D

var parent : Player = null
const angle = 45.0

func _ready() -> void:
	App._SetGravityScale(1.0)
	App.player_ignore_gravity = true
	parent = get_parent()
	parent._ChangeHitboxSize(Vector3(0.5, 0.5, 0.5))

func _exit_tree() -> void:
	App.player_ignore_gravity = false
	parent._ChangeHitboxSize(Vector3(2, 2, 2))
	
func _physics_process(delta: float) -> void:
	var process_mat = $trail.process_material as ParticleProcessMaterial
	process_mat.initial_velocity_min = 0.5 * App.player_speed
	process_mat.initial_velocity_max = 0.5 * App.player_speed
	
	if parent.need_to_jump:
		if not parent.holding:
			parent.need_to_jump = false		
				
		parent.velocity.y =  App.gravity_scale * App.player_speed
	else:
		parent.velocity.y = -App.gravity_scale * App.player_speed

	if parent._IsOnSurface():
		parent._Kill()
	else:
		if parent.velocity.y > 0.0:
			$Pivot.rotation_degrees.x = angle
		else:
			$Pivot.rotation_degrees.x = 90.0 + angle
