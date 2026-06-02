extends Area3D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	var current = App.player
	
	if current != null:
		current._Kill()
