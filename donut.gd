extends CharacterBody2D


const SPEED = 120.0

var direction = 1;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_normal().x > 0.5 or collision.get_normal().x < -0.5:
			if direction == 1 and collision.get_normal().x < -0.5:
				direction = -1
				break
			elif direction == -1 and collision.get_normal().x > 0.5:
				direction = 1
				break	
		else:
			pass
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.name == "Porg":
			if body.has_method("power_up"):
				body.power_up(1)
			queue_free()
	else:
		pass
