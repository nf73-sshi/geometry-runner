extends Node

signal player_dead

var chunk_amount : int = 0
var farthest_z : float = 0.0
const min_dist_to_spawn = 300.0

@export var all_chunks : Array[PackedScene] = []
var current_chunks : Array

#var test_chunk = preload("res://Chunks/chunk_2.tscn")
var test_chunk = null

var score : int = 0

func _SpawnChunk():
	_UpdateFarthest()
	
	var game = get_tree().get_first_node_in_group("Game")
	if game == null:
		return

	if current_chunks.is_empty():
		current_chunks.append_array(all_chunks)
		
	var i = randi() % current_chunks.size()
	var c : Chunk = null
	
	if test_chunk == null:
		c = current_chunks[i].instantiate() as Chunk
		current_chunks.remove_at(i)
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

func Reset():
	score = 0
	current_chunks.clear()
	pass

func _ready() -> void:
	for c in all_chunks:
		print(c)
func _physics_process(delta: float) -> void:
	if farthest_z < min_dist_to_spawn:
		_SpawnChunk()
		
	pass
