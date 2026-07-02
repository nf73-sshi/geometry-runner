extends Node3D

@export var min_speed = 0.75
@export var max_speed = 1.5

##-1 = backward | 0 = random | 1 = forward
@export var sens : int = 0

var final_speed = 0

func _ready() -> void:
	if sens == 0:
		sens = 1 if randi_range(0, 1) else -1
		
	clamp(sens, -1, 1)
	if max_speed < min_speed:
		max_speed = min_speed
		
	final_speed = randf_range(min_speed, max_speed)
	
func _physics_process(delta: float) -> void:
	rotation.z += sens * final_speed * delta
