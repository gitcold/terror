extends Control
var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current

func _ready() -> void:
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene


func _on_button_play_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_button_quit_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	get_tree().quit()
