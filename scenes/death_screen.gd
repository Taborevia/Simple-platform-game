extends CanvasLayer

@onready var death_screen = $ColorRect  # Pobieramy tło
@onready var try_again_button = $ColorRect/TextureButton  # Pobieramy przycisk

func _ready():
	hide()  
	try_again_button.pressed.connect(restart_game) 

func show_death_screen():
	print("tutaj")
	death_screen.modulate.a = 0  # Ukrywamy tło na start
	show()
	
	# Efekt fade-in (zanikanie)dddd
	var tween = get_tree().create_tween()
	tween.tween_property(death_screen, "modulate:a", 1.0, 1.5)  # Stopniowe przyciemnienie

func restart_game():
	get_tree().reload_current_scene()  # Restart poziomu
	GameManager.score = 0
