extends CharacterBody2D


const SPEED = 450.0
const JUMP_VELOCITY = -1300.0

@onready var porg_sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	power_up(0.5)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("player_jump") and velocity.y < 0:
		velocity.y *= 0.5;



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func power_up(num: float) -> void:
	if collision_shape.shape is RectangleShape2D:
		collision_shape.shape.size = Vector2(num * 64, num * 96)
		porg_sprite.scale = Vector2(0.192 * num, 0.192*num)
	
