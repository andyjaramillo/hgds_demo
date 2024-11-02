extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animation_player = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not is_on_floor() and velocity.y > 0:
		animation_player.play("fall")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			animation_player.play("jump_1")
			audio.play()
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			animation_player.play("run")
		else:
			animation_player.play("idle")

	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			animation_player.flip_h = false
		elif direction < 0:
			animation_player.flip_h = true
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
