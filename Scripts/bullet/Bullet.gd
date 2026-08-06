extends Area2D

@export var bullet_speed : float = 200
var direction: Vector2 = Vector2(1,0)

func _physics_process(delta: float) -> void:
	position += direction * bullet_speed * delta


func _on_timer_timeout() -> void:
	queue_free()
