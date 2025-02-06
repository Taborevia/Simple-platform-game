class_name MonsterHurtBox
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 4

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox == null or hitbox.owner == self.owner:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
