extends Actor

const MAXSPEED = 250
var acceleration = 0.2
var friction = 0.2
var jump_timestamp = 0
var time_now = OS.get_ticks_msec()
func _physics_process(delta: float) -> void:
	velocity = process_movement(velocity)
	
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
func process_movement(velocity: Vector2) -> Vector2:
	if not is_on_floor():
		is_jumping = true
		
		velocity.y = velocity.y
		if velocity.y < -200: #going up
			$AnimationPlayer.play("jump")
		elif velocity.y < -10:
			$AnimationPlayer.play("jumploop")
		elif velocity.y > -50 && velocity.y < 10.0: #transition
			$AnimationPlayer.play("landing")
		else: #falling
			$AnimationPlayer.play("fallloop")
	else:
		is_jumping = false
		
	time_now = OS.get_ticks_msec()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpforce
		jump_timestamp = OS.get_ticks_msec()
		# We are jumping!
		is_jumping = true
	elif Input.is_action_pressed("jump") and time_now - jump_timestamp < 200 and velocity.y < 0 and not is_on_floor():
		velocity.y += -25
		is_jumping = true
	if Input.is_action_pressed("move_right"):
		velocity.x = lerp(velocity.x, 1 * MAXSPEED, acceleration)
		$SLIME_FRAMES_ROW.flip_h = false
		# Check if we are jumping instead of if we are
		# on the floor
		if not is_jumping:
			$AnimationPlayer.play("move")
	elif Input.is_action_pressed("move_left"):
		velocity.x = lerp(velocity.x, -1 * MAXSPEED, acceleration)
		$SLIME_FRAMES_ROW.flip_h = true
		# Same here
		if not is_jumping:
			$AnimationPlayer.play("move") 
	else:
		# Same here
		if not is_jumping:
			velocity.x = lerp(velocity.x, 0, friction)
			$AnimationPlayer.play("idle")
			
	velocity.y = velocity.y + gravity
	return velocity



