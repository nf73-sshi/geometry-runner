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
	if parent.need_to_jump:
		if not parent.holding:
			parent.need_to_jump = false		
				
		parent.velocity.y =  App.gravity_scale * App.player_speed
	else:
		parent.velocity.y = -App.gravity_scale * App.player_speed

	if parent._IsOnSurface():
		rotation_degrees.x = 90.0
	else:
		if parent.velocity.y > 0.0:
			rotation_degrees.x = angle
		else:
			rotation_degrees.x = 90.0 + angle
