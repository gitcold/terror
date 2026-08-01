extends Area2D

@export var bullet_speed : float = 200
var direction: Vector2 = Vector2(1,0)
var is_lose : bool = false

func _ready() -> void:
	#rotation = direction.angle()
	await get_tree().create_timer(10).timeout
	#if is_lose:
	#	return
	queue_free()


func _physics_process(delta: float) -> void:
	is_lose = get_tree().current_scene.is_lose
	#if is_lose:
	#	return
	position += direction * bullet_speed * delta
