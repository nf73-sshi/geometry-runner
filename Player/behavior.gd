class_name Player

extends CharacterBody3D
signal dead

enum INPUT {LEFT, JUMP, RIGHT}
var start_pos : Vector3 = Vector3.ZERO

var touch_start_pos = Vector2.ZERO
var swipe_triggered : bool = false

var current_lane = 0
var need_to_jump : bool = false

func _Kill():
	dead.emit()
	queue_free()
	
func _Jump(intensity):	
	velocity.y = intensity
	
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
	if Input.is_action_just_pressed("jump"):
		need_to_jump = true
		$bufferTimer.start()
					
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
			$bufferTimer.start()

func _ready() -> void:
	$bufferTimer.stop()
	start_pos = global_position
	pass 

func _physics_process(delta):
	if global_position.y < -50.0:
		_Kill()
		return
	
	_KeyboardInputs()
	
	if need_to_jump:
		if is_on_floor():
			need_to_jump = false		
			_Jump(App.player_jump_impulse)
	
	var cible_x : float = start_pos.x - (current_lane * 2.5)
	global_position.x = move_toward(global_position.x, cible_x, App.player_speed * 2.0 * delta)
	
	global_position.z += delta * App.player_speed	
	velocity.y = velocity.y - (App.player_fall_speed * delta)

	if not is_on_floor():
		rotation_degrees.x += delta * 300.0
	else:
		rotation_degrees.x = round(rotation_degrees.x / 90.0) * 90.0
	
	move_and_slide()

func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		touch_start_pos = event.position
		swipe_triggered = false
	
	elif event is InputEventScreenDrag and not swipe_triggered:
		var current_vector = event.position - touch_start_pos	
		if current_vector.length() > 75.0:
			var direction = current_vector.normalized()
			_Handle_swipe(direction)
			
			swipe_triggered = true

func _on_buffer_timer_timeout() -> void:
	need_to_jump = false
