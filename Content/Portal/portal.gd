extends Node3D

var meshColor : Color = Color.BLACK
@export var gameMode : App.GAMEMODE = App.GAMEMODE.Cube

func _ready() -> void:
	match(gameMode):
		App.GAMEMODE.Cube:
			meshColor = Color.GREEN
		App.GAMEMODE.Ship:
			meshColor = Color.MAGENTA
		App.GAMEMODE.Ball:
			meshColor = Color.RED
		App.GAMEMODE.Ufo:
			meshColor = Color.ORANGE
		App.GAMEMODE.Wave:
			meshColor = Color.CYAN
		App.GAMEMODE.Robot:
			meshColor = Color.WHITE
			
	$mesh.get_active_material(0).albedo_color = meshColor
	$mesh.get_active_material(0).emission = meshColor
	
	$OrbUp/mesh.get_active_material(0).albedo_color = meshColor
	$OrbUp/mesh.get_active_material(0).emission = meshColor
	pass

func _on_hitbox_body_entered(body: Node3D) -> void:
	App._ChangeGameMode(gameMode)
