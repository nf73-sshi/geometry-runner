extends Node3D

var parent : Player = null
const max_angle = 45.0

func _ready() -> void:
	App._SetGravityScale(0.4)
	App.player_max_velocity_y = 20.0
	App.player_fall_speed = 70
	parent = get_parent()

func _exit_tree() -> void:
	App.player_max_velocity_y = 60.0
	App.player_ignore_gravity = false
	App.player_fall_speed = 98

func _physics_process(delta: float) -> void:
	if parent.need_to_jump:
		App.player_ignore_gravity = true
		if not parent.holding:
			parent.need_to_jump = false		
			
		parent.velocity.y = clampf(parent.velocity.y + App.gravity_scale * (App.player_fall_speed * delta) * 1.2, -App.player_max_velocity_y, App.player_max_velocity_y)
	else:
		App.player_ignore_gravity = false
		
	var ratio = parent.velocity.y / App.player_max_velocity_y
	var sens = 1.0
	
	if App.gravity_scale > 0.0:
		rotation_degrees.z = 0.0
	else:
		sens = -1.0
		rotation_degrees.z = 180.0
		
	$Pivot.rotation_degrees.z = clampf(sens * ratio * max_angle, -max_angle, max_angle)
