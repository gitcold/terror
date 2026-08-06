extends Control

var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current

func _ready() -> void:
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene
	var version = ProjectSettings.get_setting("application/config/version")
	# 如果版本号未设置，给一个默认值
	if version == null or version == "":
		version = "version ???"
	$Version.text = "v " + str(version)

func _on_button_play_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_button_quit_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	get_tree().quit()


func _on_button_setting_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	get_tree().change_scene_to_file("res://Scenes/Setting.tscn")
