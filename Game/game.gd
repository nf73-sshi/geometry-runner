extends Node3D

func _ready() -> void:
	Engine.time_scale = 1.2
	App.player = $Player
	App.gravity_scale = 1.0
	
func _on_player_dead() -> void:
	$TopView.stop_follow = true
	App.player = null
	$deadTimer.start()

func _on_dead_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reboot"):
		get_tree().reload_current_scene()
