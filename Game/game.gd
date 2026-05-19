extends Node3D

func _ready() -> void:
	Engine.time_scale = 1.1
	App.player = $Player
	
func _on_player_dead() -> void:
	App.player = null
	$deadTimer.start()

func _on_dead_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
