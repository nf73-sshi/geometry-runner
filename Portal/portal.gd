extends Node3D

@export var meshColor : Color
@export var gameMode : App.GAMEMODE = App.GAMEMODE.Cube

func _ready() -> void:
	$mesh.get_active_material(0).albedo_color = meshColor
	pass

func _on_hitbox_body_entered(body: Node3D) -> void:
	App._ChangeGameMode(gameMode)
