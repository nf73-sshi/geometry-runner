extends Chunk

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_Start()
	
	var random = randi_range(1, 3)
	get_node("YellowPad" + str(random)).queue_free()
