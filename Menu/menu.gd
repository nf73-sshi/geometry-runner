extends Node2D

func _ready() -> void:
	App.player = null
	pass
	
func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/game.tscn")
