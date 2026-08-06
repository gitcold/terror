extends CharacterBody2D

var speed : float = 150
var counter : float = INF
var hp : float = 30
var dir : float = 0
var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current


var is_dead : bool = false
var is_player_in : bool = false

@export var head_texture : Sprite2D
@export var head_shape : CollisionPolygon2D

func _ready() -> void:
	randomize()
	dir = randf_range(0, 360)
	position = Vector2(400, 240) + Vector2.from_angle(dir) * -800
	rotation = dir
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene

func _physics_process(delta: float) -> void:
	if not is_dead:
		velocity = Vector2.from_angle(dir) * speed
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
	
	head_shape.rotation += 3 * delta
	head_texture.rotation += 3 * delta

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
	
