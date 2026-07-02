@tool

class_name EvilBlock
extends Node3D

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

	$killbox/hitbox.shape.size = size
		
func update_others():
	if not glow:
		$glow.queue_free()
		
func _ready() -> void:	
	update_size()
	update_others()
	
func _on_killbox_body_entered(body: Node3D) -> void:
	var current = App.player
	
	if current != null:
		current._Kill()
