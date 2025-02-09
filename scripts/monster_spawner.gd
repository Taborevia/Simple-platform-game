extends Node2D

@onready var monster_scene = preload("res://scenes/skeleton.tscn")  # Scena przeciwnika
@export var spawn_points: Array[Node2D]  # Lista punktów spawnu
@export var spawn_time: float = 2.0  # Czas między spawnami
var wave_number: int = 1  # Numer fali
var enemies_on_map: int = 0  # Liczba potworów aktualnie na mapie
@export var label: Label

func _ready():
	while !label:
		await get_tree().create_timer(0.1).timeout 
	start_wave()
	
func start_wave():
	print(label)
	enemies_on_map = 0
	var required_points = pow(2, wave_number) + 1
	var max_enemies = pow(wave_number,2)
	print(wave_number)
	label.text = "Rozpoczyna się fala: %d\nWymagane punkty do następnej fali: %d\nLimit przeciwników w tej fali: %d" % [wave_number, required_points, max_enemies]
	await get_tree().create_timer(5).timeout 
	label.text = ""


func _on_timer_timeout():
	var max_enemies = pow(2, wave_number)
	if enemies_on_map < max_enemies:
		spawn_enemy()

	# Sprawdzenie, czy gracz zdobył wystarczającą liczbę punktów
	var required_points = pow(2, wave_number) + 1
	if GameManager.score >= required_points:
		next_wave()

func spawn_enemy():
	print("tutaj")
	if spawn_points.is_empty():
		print("tutaj2")
		return

	var spawn_point = spawn_points[randi() % spawn_points.size()]
	var monster = monster_scene.instantiate()
	monster.position = spawn_point.position
	monster.monster_death.connect(_on_enemy_died)  # Połączenie sygnału śmierci potwora
	add_child(monster)

	enemies_on_map += 1

func _on_enemy_died():
	print("umarl se")
	enemies_on_map -= 1  # Zmniejszamy liczbę przeciwników na mapie

func next_wave():
	wave_number += 1
	start_wave()
