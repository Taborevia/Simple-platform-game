extends CharacterBody2D

const SPEED = 100
var direction = 1  # 1 = prawo, -1 = lewo

@onready var sprite = $AnimatedSprite2D  # Pobranie animacji
@onready var left_ray = $left  # RayCast2D po lewej stronie
@onready var right_ray = $right  # RayCast2D po prawej stronie

func _ready() -> void:
	sprite.play("moving_right")  # Startowa animacja

func _physics_process(_delta: float) -> void:
	# Sprawdzenie kolizji ze ścianą lub krawędzią platformy
	if left_ray.is_colliding() and right_ray.is_colliding():
		direction = 0
		sprite.play("idle")
	elif left_ray.is_colliding():
		direction = 1
		sprite.flip_h = false
	elif right_ray.is_colliding():
		direction = -1
		sprite.play("moving_right")
		sprite.flip_h = true
		#sprite.play("moving_left")

	# Aktualizacja prędkości ruchu
	velocity.x = direction * SPEED

	# Przesunięcie potwora
	move_and_slide()
