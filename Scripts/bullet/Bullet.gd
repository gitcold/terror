extends Area2D

@export var bullet_speed : float = 200
var direction: Vector2 = Vector2(1,0)
var is_lose : bool = false

func _ready() -> void:
	await get_tree().create_timer(10).timeout
	queue_free()


func _physics_process(delta: float) -> void:
	position += direction * bullet_speed * delta
