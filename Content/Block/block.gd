@tool

class_name Block
extends StaticBody3D

@export var kill : bool = false
@export var hide_if_near = false
@export var glow : bool = true

@export var size : Vector3:
	set(value):
		size = value
		if is_inside_tree():
			update_size()
			
func update_size():
	if glow:
		$inside.mesh.size = Vector3(size.x - 0.1, size.y - 0.1, size.z - 0.1)
		$glow.mesh.size = size
	else:
		$inside.mesh.size = size
		
	$hitbox.shape.size = size
	
	if not kill:
		$killbox/hitbox.shape.size = Vector3(size.x + 0.01, size.y - 0.35, size.z + 0.01)
	else:
		$killbox/hitbox.shape.size = size
		$glow.get_active_material(0).albedo_color = Color.RED
		
		if not Engine.is_editor_hint():
			$inside.set_surface_override_material(0, App.bloc_mat)

func update_others():
	if not glow:
		$glow.queue_free()
	if kill:
		$hitbox.queue_free()

func _ready() -> void:
	if hide_if_near:
		set_collision_layer_value(5, true)
		
	update_size()
	update_others()
	
func _on_killbox_body_entered(body: Node3D) -> void:
	var current = App.player
	
	if current != null:
		current._Kill()
