extends CharacterBody2D

@onready var character: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 55.0
const JUMP_FORCE: float = -250.0
const GRAVITY: float = 980.0

# Track current animation state
var current_animation: String = "idle"

func _ready() -> void:
	# Start with idle animation
	character.play("idle")

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	# Get movement direction
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = lerp(velocity.x, direction * SPEED, 0.1)
	
	# Handle jumping
	if Input.is_action_just_pressed("jump_space") and is_on_floor():
		velocity.y = JUMP_FORCE
		play_animation("jump")
	
	# Handle ground animations
	if is_on_floor():
		if direction != 0:
			play_animation("walk")
		else:
			play_animation("idle")
			
	# Flip character based on direction
	if direction != 0:
		character.flip_h = direction < 0
	
	if not is_on_floor():
		play_animation("jump")
	# Apply movement
	move_and_slide()

func play_animation(anim_name: String) -> void:
	# Only change animation if it's different from current
	if current_animation != anim_name:
		current_animation = anim_name
		character.play(anim_name)
