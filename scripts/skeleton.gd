extends CharacterBody2D

const SPEED = 100
var direction = 1  # 1 = prawo, -1 = lewo
var health = 100
var character_damage = 10
var points = 1
signal health_changed
signal monster_death
@onready var left_ray = $left  # RayCast2D po lewej stronie
@onready var right_ray = $right  # RayCast2D po prawej stronie
@onready var anim = $Sprites/AnimationPlayer
@onready var sprite_body = $Sprites/body

func _ready() -> void:
	anim.play("moving")  # Startowa animacja

func fade_out():
	for i in range(100):
		modulate.a = 1.0 - i * 0.01  
		await get_tree().create_timer(0.03).timeout  
	queue_free()  
	
func take_damage(damage: int) -> void:
	print("ałą za ", damage)
	health -= damage
	health_changed.emit(damage)
	if health <= 0:
		death()

func death() -> void:
	anim.play("death")
	modulate = Color(1, 0, 0)  # Ustawia kolor na czerwony
	GameManager.add_score(points)
	monster_death.emit()
	await get_tree().create_timer(0.2).timeout  # Czeka 0.2 sekundy
	modulate = Color(1, 1, 1)  # Przywraca normalny kolor
	fade_out()
	
func _physics_process(delta: float) -> void:
	# Sprawdzenie kolizji ze ścianą lub krawędzią platformy
	if (health>0):
		if not is_on_floor():
			velocity += get_gravity() * delta
		if left_ray.is_colliding() and right_ray.is_colliding():
			direction = 0
			anim.play("idle")
		elif left_ray.is_colliding():
			direction = 1
			anim.play("moving")
			sprite_body.flip_h = false
		elif right_ray.is_colliding():
			direction = -1
			anim.play("moving")
			sprite_body.flip_h = true

		# Aktualizacja prędkości ruchu
		velocity.x = direction * SPEED

		# Przesunięcie potwora
		move_and_slide()
