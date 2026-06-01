class_name Chunk
extends Node3D
var size_z : float = 0.0

func _Start():
	GameManager.chunk_amount += 1
	size_z = $Base.size.z
	
func _ready() -> void:
	_Start()

func _exit_tree() -> void:
	GameManager.chunk_amount -= 1
	GameManager._UpdateFarthest()
	
func _physics_process(delta: float) -> void:
	global_position.z -= App.player_speed * delta

func _on_screen_visibility_screen_exited() -> void:
	
	queue_free()
