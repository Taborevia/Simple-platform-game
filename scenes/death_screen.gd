extends CanvasLayer

@onready var death_screen = $ColorRect  # Pobieramy tło
@onready var try_again_button = $TextureButton  # Pobieramy przycisk

func _ready():
	hide()  # Ukrywamy ekran na start
	try_again_button.pressed.connect(restart_game)  # Podłączamy przycisk

func show_death_screen():
	death_screen.modulate.a = 0  # Ukrywamy tło na start
	show()
	
	# Efekt fade-in (zanikanie)
	var tween = get_tree().create_tween()
	tween.tween_property(death_screen, "modulate:a", 1.0, 1.5)  # Stopniowe przyciemnienie

func restart_game():
	get_tree().reload_current_scene()  # Restart poziomu
