extends Area2D

@export var bullet_speed : float = 100
var direction: Vector2 = Vector2(1,0)

func _ready() -> void:
	#rotation = direction.angle()
	await get_tree().create_timer(10).timeout
	queue_free()


func _physics_process(delta: float) -> void:
	position += direction * bullet_speed * delta
