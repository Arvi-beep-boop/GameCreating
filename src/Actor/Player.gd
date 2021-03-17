extends Actor

const MAXSPEED = 200
var acceleration = 0.3
var friction = 0.6
var jump_timestamp = 0
var time_now = OS.get_ticks_msec()


func _physics_process(delta: float) -> void:
	velocity = process_movement(velocity)
	
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
func process_movement(velocity: Vector2) -> Vector2:
	if not is_on_floor():
		is_jumping = true
		
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
	var jump_duration = time_now - jump_timestamp
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpforce
		print(jumpforce)
		jump_timestamp = OS.get_ticks_msec()
		# We are jumping!
		is_jumping = true
	elif Input.is_action_pressed("jump") and (jump_duration < 100 and jump_duration > 50) \
		and velocity.y < 0 and not is_on_floor():
			
		velocity.y = jumpforce
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








func _on_DeathDetector_body_entered(body):
	if body.get_class() == "Spikes":
		get_tree().reload_current_scene()
