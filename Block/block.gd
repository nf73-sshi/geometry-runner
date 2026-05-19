@tool

extends StaticBody3D

@export var size : Vector3:
	set(value):
		size = value
		if is_inside_tree():
			update_size()
			
func update_size():
	$inside.mesh.size = Vector3(size.x - 0.1, size.y - 0.1, size.z - 0.1)
	$glow.mesh.size = size
	$hitbox.shape.size = Vector3(size.x, 0.1, size.z)
	$hitbox.position.y = size.y * 0.5 - 0.1
	$killbox/hitbox.shape.size = Vector3(size.x, size.y - 0.5, size.z)
	
func _ready() -> void:
	update_size()
	
func _process(delta: float) -> void:
	pass

func _on_killbox_body_entered(body: Node3D) -> void:
	var current = App.player
	
	if current != null:
		current._Kill()
