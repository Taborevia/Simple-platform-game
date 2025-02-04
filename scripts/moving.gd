extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
@onready var anim = $Sprites/AnimationPlayer
@onready var sprite_hands = $Sprites/hands
@onready var sprite_body = $Sprites/body
@onready var sprite_sword = $Sprites/sword

func attack():
	sprite_sword.visible = true  # Pokazuje miecz
	anim.play("attack")  # Odtwarza animację ataku

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if Input.is_action_just_pressed("ui_attack"):
		anim.play("attack")
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if anim.current_animation != "attack":
			if direction == 1:
				anim.play("moving")
				sprite_body.flip_h = false
				sprite_hands.flip_h = false
				sprite_sword.flip_h = false
			else:
				anim.play("moving")
				sprite_body.flip_h = true
				sprite_hands.flip_h = true
				sprite_sword.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor()  and anim.current_animation != "attack":
			anim.play("idle")
	move_and_slide()
