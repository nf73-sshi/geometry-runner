extends Node

var chunk_3 = preload("res://Chunks/chunk_3.tscn")

var chunk_amount : int = 0
var farthest_z : float = 0.0
const min_dist_to_spawn = 300.0

func _SpawnChunk():
	_UpdateFarthest()
	
	var game = get_tree().get_first_node_in_group("Game")
	if game == null:
		return
		
	var c = chunk_3.instantiate() as Chunk

	game.add_child(c)
	c.global_position.z = farthest_z + c.size_z * 0.5

func _UpdateFarthest():
	farthest_z = 0.0
	var current_z = -10000.0
	
	for chunk : Chunk in get_tree().get_nodes_in_group("Chunk"):
		current_z = chunk.global_position.z + chunk.size_z * 0.5
		
		if current_z > farthest_z:
			farthest_z = current_z

func _on_reset():
	pass
		
func _ready() -> void:
	App.on_reset.connect(_on_reset)
	pass
	
func _physics_process(delta: float) -> void:
	print(chunk_amount)

	if farthest_z < min_dist_to_spawn:
		_SpawnChunk()
		
	pass
