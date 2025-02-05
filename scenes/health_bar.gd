extends TextureProgressBar

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.health_changed.connect(update)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	value = player.health
	if value <= 0:
		visible = false
