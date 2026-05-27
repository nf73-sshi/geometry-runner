@tool

extends StaticBody3D

static var surface_override : StandardMaterial3D = StandardMaterial3D.new()

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
		$inside.set_surface_override_material(0, surface_override)
		$inside.mesh.size = size
		$glow.queue_free()
		
	$hitbox.shape.size = size
	$killbox/hitbox.shape.size = Vector3(size.x + 0.01, size.y - 0.35, size.z + 0.01)
	
func _ready() -> void:
	surface_override.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	surface_override.albedo_color = Color(0, 0,0, 0.8)
	update_size()
	
func _on_killbox_body_entered(body: Node3D) -> void:
	var current = App.player
	
	if current != null:
		current._Kill()
