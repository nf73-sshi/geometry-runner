class_name Player

extends CharacterBody3D
signal dead

enum INPUT {LEFT, JUMP, RIGHT}
var start_pos : Vector3 = Vector3.ZERO

var holding : bool = false
var touch_start_pos = Vector2.ZERO
var swipe_triggered : bool = false

var current_lane = 0
var need_to_jump : bool = false
var need_to_trigger_interact : bool = false

var middle_screen_x : float = 0.0
		
func _Kill():
	dead.emit()
	queue_free()
	
func _Jump(intensity):	
	velocity.y = App.gravity_scale * intensity
	
func _Handle_swipe(direction):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			_ApplyInput(INPUT.RIGHT)
		else:
			_ApplyInput(INPUT.LEFT)
	else:
		if direction.y < 0:
			_ApplyInput(INPUT.JUMP)

func _KeyboardInputs():
	if Input.is_action_just_pressed("move_left"):
		_ApplyInput(INPUT.LEFT)
	if Input.is_action_just_pressed("move_right"):
		_ApplyInput(INPUT.RIGHT)

func _ApplyInput(i) :
	match(i):
		INPUT.LEFT:
			$anim.stop()
			$anim.play("swipe_left")
			if current_lane <= -1:
				return
			current_lane -= 1
			
		INPUT.RIGHT:
			$anim.stop()
			$anim.play("swipe_right")
			if current_lane >= 1:
				return
			current_lane += 1
			
		INPUT.JUMP:
			need_to_jump = true
			need_to_trigger_interact = true

func _ready() -> void:
	start_pos = global_position
	middle_screen_x = get_viewport().get_visible_rect().size.x / 2.0
	pass 

func _physics_process(delta):
	print(App.gravity_scale)
	if global_position.y < -50.0:
		_Kill()
		return
	
	_KeyboardInputs()
	
	if need_to_jump:
		if is_on_floor():
			need_to_trigger_interact = false
			if not holding:
				need_to_jump = false		
			_Jump(App.player_jump_impulse)
	
	var cible_x : float = start_pos.x - (current_lane * 2.5)
	global_position.x = move_toward(global_position.x, cible_x, App.player_speed * 2.0 * delta)
	
	global_position.z += delta * App.player_speed	
	velocity.y = clampf(velocity.y - App.gravity_scale * (App.player_fall_speed * delta), -App.player_max_velocity_y, App.player_max_velocity_y)

	if not is_on_floor():
		rotation_degrees.x += delta * 300.0
	else:
		rotation_degrees.x = round(rotation_degrees.x / 90.0) * 90.0
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			touch_start_pos = event.position
			swipe_triggered = false
			holding = true
			
			if event.position.x > middle_screen_x:
				_ApplyInput(INPUT.JUMP)
		else:
			holding = false
			need_to_trigger_interact = false
			need_to_jump = false
	
	if event is InputEventScreenDrag and not swipe_triggered:
		var current_vector = event.position - touch_start_pos	
		if event.position.x > middle_screen_x:
			return
		
		if current_vector.length() > 30.0:
			var direction = current_vector.normalized()
			_Handle_swipe(direction)		
			swipe_triggered = true
