extends Node

signal player_dead
var chunk_amount : int = 0
var farthest_z : float = 0.0
const min_dist_to_spawn = 300.0

var all_chunks : Array
var test_chunk = null

func _InitChunks():
	var path = "res://Chunks/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.contains("chunk_") and file_name.ends_with("tscn"):
					print("Found Chunk : " + file_name)
					all_chunks.append(load(path + file_name))
				
			file_name = dir.get_next()
			
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")

func _SpawnChunk():
	_UpdateFarthest()
	
	var game = get_tree().get_first_node_in_group("Game")
	if game == null:
		return

	if all_chunks.is_empty():
		return
				
	var i = randi() % all_chunks.size()
	var c : Chunk = null
	
	if test_chunk == null:
		c = all_chunks[i].instantiate() as Chunk
	else:
		c = test_chunk.instantiate()
		
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
	_InitChunks()
	App.on_reset.connect(_on_reset)
	pass
	
func _physics_process(delta: float) -> void:
	if farthest_z < min_dist_to_spawn:
		_SpawnChunk()
		
	pass
