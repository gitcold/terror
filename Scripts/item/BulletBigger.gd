extends Area2D

var item_name : String = "BulletBigger"
var counter : float = 75
var is_dead : bool = false

func _ready() -> void:
	randomize()
	counter = randi_range(75, 80)

func _physics_process(delta: float) -> void:
	counter -= delta
	rotation += randf_range(5,5) * delta
	if counter < 0:
		is_dead = true
	if is_dead:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().current_scene.give_player_item(item_name, 8)
		is_dead = true
	
