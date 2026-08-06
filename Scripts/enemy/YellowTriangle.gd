extends CharacterBody2D

var speed : float = 15
var counter : float = INF
var hp : float = 1
var r : float = 75
var move_area_r : float = r + 20
var dir : float = 0
var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current


var is_dead : bool = false
var is_player_in : bool = false

func _ready() -> void:
	randomize()
	dir = randf_range(0, 360)
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene


func _physics_process(delta: float) -> void:
	var player_pos = get_tree().current_scene.get_player_pos()
	var aim_pos = player_pos + Vector2(cos(dir), sin(dir)) * r
	var distance = position.distance_to(aim_pos)
	if not is_dead:
		look_at(aim_pos)
		var theta = rotation
		if distance >= move_area_r:
			velocity = Vector2(cos(theta), sin(theta)) * distance * speed * log(1.3) / 2.5
		else:
			velocity = Vector2(cos(theta), sin(theta)) * distance * speed * log(1.2)
	move_and_slide()
	if is_player_in:
		get_tree().current_scene.attack_player()
	counter -= delta
	if counter < 0:
		is_dead = true
	if hp <= 0:
		is_dead = true
	if is_dead:
		wav_player.play_wav("res://assets/wav/hitHurt.wav", current)
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
	
