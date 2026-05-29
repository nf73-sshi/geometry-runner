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
		$glow.queue_free()
		
	$hitbox.shape.size = size
	
	if not kill:
		$killbox/hitbox.shape.size = Vector3(size.x + 0.01, size.y - 0.35, size.z + 0.01)
	else:
		$hitbox.queue_free()
		$killbox/hitbox.shape.size = size
		$glow.get_active_material(0).albedo_color = Color.RED
		$inside.set_surface_override_material(0, StandardMaterial3D.new())
		var inside_mat = $inside.get_surface_override_material(0) as StandardMaterial3D
		inside_mat.roughness = 1.0
		inside_mat.metalness = 1.0
		inside_mat.specular = 1.0
		inside_mat.albedo_color = Color(0.2, 0, 0, 1)
	
func _ready() -> void:
	if hide_if_near:
		set_collision_layer_value(5, true)
		
	update_size()
	
func _on_killbox_body_entered(body: Node3D) -> void:
	var current = App.player
	
	if current != null:
		current._Kill()
