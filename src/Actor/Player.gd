extends Actor

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	
	
func get_direction() -> Vector2:
	var direction = Vector2()
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		direction.y = -1.0
	else:
		direction.y = 0.0
	
	return direction
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y <= -1.0:
		new_velocity.y = speed.y * direction.y
	
	return new_velocity
	
	
func _process(delta):
	if Input.is_action_pressed("move_right"):
		$SLIME_FRAMES_ROW.flip_h = false
		$AnimationPlayer.play("move")
		
	elif Input.is_action_pressed("move_left"):
		$SLIME_FRAMES_ROW.flip_h = true
		$AnimationPlayer.play("move")
		
	else:
		$AnimationPlayer.play("idle")
		

