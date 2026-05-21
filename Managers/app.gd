extends Node

enum GAMEMODE {Cube, Ship, Ball, Ufo, Wave, Robot, Spider, Swing}
var current_game_mode : GAMEMODE = GAMEMODE.Cube
var cube = preload("res://Player/Cube/cube.tscn")
var ship = preload("res://Player/Ship/ship.tscn")
var ball = preload("res://Player/Ball/ball.tscn")

var player_ignore_gravity : bool = false
var player_speed : float = 15.0
var player_fall_speed = 98
var player_jump_impulse = 30
var player_max_velocity_y = 60.0

var player : Player = null
var gravity_scale : float = 1.0

func _ChangeGameMode(mode : GAMEMODE):
	if player == null or current_game_mode == mode:
		return
	
	for child in player.get_children():
		print(child)
		if child.is_in_group("GameMode"):
			child.queue_free()
		
	match(mode):
		GAMEMODE.Cube:
			player.add_child(cube.instantiate())
			pass
		GAMEMODE.Ship:
			player.add_child(ship.instantiate())
			pass
		GAMEMODE.Ball:
			player.add_child(ball.instantiate())
			pass

func _SetGravityScale(val):
	if gravity_scale > 0.0:
		gravity_scale = val
	else:
		gravity_scale = -val

func _ReverseGravity():
	gravity_scale *= -1.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
