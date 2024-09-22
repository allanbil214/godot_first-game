extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0
var is_dead: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if is_dead:
		# Allow only downward movement (gravity), prevent horizontal movement
		velocity.x = 0  # Stop horizontal movement
		if not is_on_floor():
			velocity += get_gravity() * delta  # Still apply gravity for falling
		move_and_slide()
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip Player
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Play more sprite
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Function to set the death state
func die() -> void:
	is_dead = true
	# Optionally, you can also stop animations or play a death animation here
	animated_sprite_2d.play("death")  # Play death animation if available
	velocity = Vector2.ZERO  # Stop all movement
