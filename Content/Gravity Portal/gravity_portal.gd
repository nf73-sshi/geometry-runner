extends Node3D

enum Type {NORMAL, REVERSE, INVERT}
var meshColor : Color
@export var type = Type.NORMAL

func _ready() -> void:
	match(type):
		Type.NORMAL:
			meshColor = Color.DODGER_BLUE
		Type.REVERSE:
			meshColor = Color.YELLOW
		Type.INVERT:
			meshColor = Color.GREEN
			
	$mesh.get_active_material(0).albedo_color = meshColor
	$mesh.get_active_material(0).emission = meshColor

func _on_hitbox_body_entered(body: Node3D) -> void:
	match(type):
		Type.NORMAL:
			App.gravity_scale = abs(App.gravity_scale)
		Type.REVERSE:
			App.gravity_scale = -abs(App.gravity_scale)
		Type.INVERT:
			App._ReverseGravity()
