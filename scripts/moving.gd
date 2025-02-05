class_name Player
extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
var last_direction = 1
var health = 100
var character_damage = 50
signal health_changed
@export var death_screen: CanvasLayer 
@onready var anim = $Sprites/AnimationPlayer
@onready var sprite_hands = $Sprites/hands
@onready var sprite_body = $Sprites/body
@onready var sprite_sword = $Sprites/sword

func _physics_process(delta: float) -> void:
	if health >= 0:
		if Input.is_action_just_pressed("ui_attack"):
			if last_direction == 1:
				anim.play("swing_right")
			if last_direction == -1:
				anim.play("swing_left")
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
			if anim.current_animation != "swing_right" and anim.current_animation != "swing_left":
				last_direction = direction
				if direction == 1:
					anim.play("moving")
					sprite_body.flip_h = false
					sprite_hands.flip_h = false
					sprite_sword.flip_h = false
					sprite_sword.position.x = 8.5
					sprite_sword.position.y = -8.7
					#sprite_sword.scale.x = 1
					#sprite_sword.offset = Vector2(0,0)
				else:
					anim.play("moving")
					sprite_body.flip_h = true
					sprite_hands.flip_h = true
					sprite_sword.flip_h = true
					sprite_sword.position.x = -8.5
					sprite_sword.position.y = -8.7
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor() and anim.current_animation != "swing_right" and anim.current_animation != "swing_left":
				anim.play("idle")
		move_and_slide()
	
func take_damage(damage: int) -> void:
	print("ałaaaa za ", damage)
	health -= damage
	health_changed.emit(damage)
	if health<=0:
		death()

func death() -> void:
	set_physics_process(false)  # Wyłączamy fizykę
	set_process(false)
	anim.play("death")
	modulate = Color(1, 0, 0)  # Ustawia kolor na czerwony
	await get_tree().create_timer(0.2).timeout  # Czeka 0.2 sekundy
	modulate = Color(1, 1, 1)  # Przywraca normalny kolor
	await get_tree().create_timer(0.5).timeout
	
	if death_screen:
		death_screen.show_death_screen()
	
