extends Node

@export var wav_scene : PackedScene = preload("res://Scenes/WavPlayer.tscn")

func play_wav(wav_path : String, current) -> void:
	var wav = load(wav_path)
	var wav_node = load("res://Scenes/WavPlayer.tscn").instantiate()
	wav_node.stream = wav
	print(wav_node)
	current.add_child(wav_node)
