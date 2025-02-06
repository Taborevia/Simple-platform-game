class_name MyHitBox
extends Area2D

var damage := 10

func _init() -> void:
	collision_layer = 4
	collision_mask = 0
func _ready() -> void:
	if owner and owner is CharacterBody2D:  # Sprawdzenie, czy owner istnieje i ma odpowiedni typ
		damage = owner.character_damage
	
