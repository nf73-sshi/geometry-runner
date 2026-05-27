extends Node3D

func _ready() -> void:
	GameManager.player_dead.connect(_on_player_dead)
	Engine.time_scale = 1.25
	App._Reset()
	App.player = $Player
	
func _on_player_dead() -> void:
	App.player_speed = 0.0
	App.player = null
	$deadTimer.start()

func _on_dead_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
	
func _process(delta: float) -> void:
	print(Engine.time_scale)
	if Input.is_action_just_pressed("reboot"):
		get_tree().reload_current_scene()
	
func _on_speed_up_timeout() -> void:
	if Engine.time_scale >= 3.0:
		$SpeedUp.stop()
	else:
		if Engine.time_scale >= 2.45:
			Engine.time_scale += 0.025
		else:
			Engine.time_scale += 0.05
