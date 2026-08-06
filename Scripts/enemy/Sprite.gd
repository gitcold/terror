extends CharacterBody2D

@export var speed : float = 45
@export var counter : float = 180
@export var hp : float = 5
@export var move_area_r : float = 5
var aim_pos : Vector2
var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current

var is_dead : bool = false
var is_player_in : bool = false

func _ready() -> void:
	randomize()
	aim_pos = Vector2(randf_range(20, 780),randf_range(20, 460))
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene
	

func _physics_process(delta: float) -> void:
	var distance = position.distance_to(aim_pos)
	if not is_dead:
		if distance >= move_area_r:
			velocity = (aim_pos-position).normalized() * speed
		else:
			velocity = Vector2.ZERO
			aim_pos = Vector2(randf_range(20, 780),randf_range(20, 460))
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
