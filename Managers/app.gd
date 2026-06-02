extends Node

signal on_reset

static var bloc_mat = StandardMaterial3D.new()

#Gamemodes
enum GAMEMODE {Cube, Ship, Ball, Ufo, Wave, Robot, Spider, Swing}
var current_game_mode : GAMEMODE = GAMEMODE.Cube
var cube = preload("res://Content/Player/Cube/cube.tscn")
var ship = preload("res://Content/Player/Ship/ship.tscn")
var ball = preload("res://Content/Player/Ball/ball.tscn")
var ufo = preload("res://Content/Player/Ufo/ufo.tscn")
var wave = preload("res://Content/Player/Wave/wave.tscn")
var robot = preload("res://Content/Player/Robot/robot.tscn")

#Player
var player_ignore_gravity : bool = false
var player_speed : float = 15.0
var player_fall_speed = 98
var player_jump_impulse = 30
var player_max_velocity_y = 60.0

var player : Player = null
var gravity_scale : float = 1.0

func _Reset():
	player_ignore_gravity = false
	player_speed = 15.0
	player_fall_speed = 98
	player_jump_impulse = 30
	player_max_velocity_y = 60.0
	current_game_mode = GAMEMODE.Cube
	player = null
	gravity_scale = 1.0

	on_reset.emit()

func _ChangeGameMode(mode : GAMEMODE):
	if player == null or current_game_mode == mode:
		return
	
	current_game_mode = mode
	player.velocity.y *= 0.5
	
	for child in player.get_children():
		if child.is_in_group("GameMode"):
			child.queue_free()
		
	match(mode):
		GAMEMODE.Cube:
			player.add_child(cube.instantiate())
		GAMEMODE.Ship:
			player.add_child(ship.instantiate())
		GAMEMODE.Ball:
			player.add_child(ball.instantiate())
		GAMEMODE.Ufo:
			player.add_child(ufo.instantiate())
		GAMEMODE.Wave:
			player.add_child(wave.instantiate())
		GAMEMODE.Robot:
			player.add_child(robot.instantiate())
		

func _SetGravityScale(val):
	if gravity_scale > 0.0:
		gravity_scale = val
	else:
		gravity_scale = -val

func _ReverseGravity():
	gravity_scale *= -1.0

func _ready() -> void:
		bloc_mat.roughness = 1.0
		bloc_mat.metalness = 1.0
		bloc_mat.specular = 1.0
		bloc_mat.albedo_color = Color(0.2, 0, 0, 1)
		
func _process(delta: float) -> void:
	pass
