extends CharacterBody2D

@export var speed : float = 75
@export var counter : float = INF
@export var hp : float = 1
@export var move_area_r : float = 5

var is_dead : bool = false
var is_player_in : bool = false


func _physics_process(delta: float) -> void:
	var player_pos = get_tree().current_scene.get_player_pos()
	var distance = position.distance_to(player_pos)
	if not is_dead:
		look_at(player_pos)
		if distance >= move_area_r:
			velocity = (player_pos-position).normalized() * speed
		else:
			velocity = Vector2.ZERO
	move_and_slide()
	if is_player_in:
		get_tree().current_scene.attack_player()
	counter -= delta
	if counter < 0:
		is_dead = true
	if hp <= 0:
		is_dead = true
	if is_dead:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in = false
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		hp -= 1
		area.queue_free()
	elif area.is_in_group("laser"):
		hp -= 1
	
