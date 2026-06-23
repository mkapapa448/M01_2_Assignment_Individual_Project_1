extends CharacterBody2D

signal die

const SPEED = 450.0
const JUMP_VELOCITY = -1300.0

@onready var porg_sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var power_level = 0.5

var knockback = 0

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
	
	if knockback != 0:
		velocity.x = SPEED * knockback * 2
		velocity.y = JUMP_VELOCITY / 2
		knockback = 0
	
	move_and_slide()
	
	knockback = 0
	
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_normal().y > 0.5 and collision.get_collider().has_method('dispense'):
			collision.get_collider().dispense()
			break
		elif collision.get_collider() is CharacterBody2D and collision.get_collider().has_method('die'): 
			if collision.get_normal().y < -0.5:
				collision.get_collider().die()
				velocity.y = JUMP_VELOCITY / 2
				break
				
			else:
				if power_level > 0.5:
					if collision.get_normal().x > 0.1:
						knockback = 1
					elif collision.get_normal().x < -0.1:
						knockback = -1
					power_up(0.5)
				else:
					death()
				break
	
func death():
	die.emit()

func power_up(num: float) -> void:
	if collision_shape.shape is RectangleShape2D:
		collision_shape.shape.size = Vector2(num * 64, num * 96)
		porg_sprite.scale = Vector2(0.192 * num, 0.192*num)
	power_level = num

func loser():
	velocity.y = JUMP_VELOCITY * 0.9
	$CollisionShape2D.set_deferred('disabled', true)

func winner():
	velocity.y = JUMP_VELOCITY * 3
