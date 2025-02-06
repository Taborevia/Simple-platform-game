extends Node

var score: int = 0  # Przechowuje aktualną liczbę punktów

# Funkcja do dodawania punktów
func add_score(points: int):
	score += points
	print("Punkty: ", score)  # Debugging, możesz zamienić to na aktualizację UI
