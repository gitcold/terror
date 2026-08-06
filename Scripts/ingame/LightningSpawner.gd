extends Node2D

const first_count : Vector2 = Vector2(20, 30)
const count : Vector2 = Vector2(30, 60)
var spawn_count : float = 0
var lightning_scene: PackedScene = preload("res://Scenes/Lightning.tscn")
var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current

func _ready() -> void:
	randomize()
	spawn_count = randf_range(first_count.x, first_count.y)
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene
	
func _process(delta: float) -> void:
	if not Global.is_lightning:
		return
	spawn_count -= delta
	if spawn_count <= 0:
		spawn_count = randf_range(count.x, count.y)
		wav_player.play_wav("res://assets/wav/lightning.mp3", current)
		var lightning_node = lightning_scene.instantiate()
		get_tree().current_scene.add_child(lightning_node)
