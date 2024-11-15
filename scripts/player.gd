extends CharacterBody2D

@onready var character: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 300.0
const JUMP_FORCE: float = -400.0
const GRAVITY: float = 1200.0

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	# Handle jumping
	if Input.is_action_just_pressed("jump_space") and is_on_floor():
		velocity.y = JUMP_FORCE
		character.play("jump")
	
	# Handle horizontal movement
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = lerp(velocity.x, direction * SPEED, 0.1)
	
	if direction != 0:
		if is_on_floor():
			character.play("walk")
		character.flip_h = direction < 0
	else:
		if is_on_floor():
			character.play("idle")
	
	# Apply movement
	move_and_slide()
