extends Actor



func _physics_process(delta: float) -> void:
	velocity = process_movement(velocity)
	
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	velocity.x = lerp(velocity.x,0,0.1)
	
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
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpforce
		# We are jumping!
		is_jumping = true
		
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		$SLIME_FRAMES_ROW.flip_h = false
		# Check if we are jumping instead of if we are
		# on the floor
		if not is_jumping:
			$AnimationPlayer.play("move")
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		$SLIME_FRAMES_ROW.flip_h = true
		# Same here
		if not is_jumping:
			$AnimationPlayer.play("move") 
	else:
		# Same here
		if not is_jumping:
			$AnimationPlayer.play("idle")
			
	velocity.y = velocity.y + gravity
	return velocity



