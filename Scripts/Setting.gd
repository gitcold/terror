extends Control

var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current

func _ready() -> void:
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene

func _process(delta: float) -> void:
	$MoveMode.text = "Move Mode: " + str(Global.MOVE_MODE.find_key(Global.move_mode)).to_lower()
	$Fog.text = "Fog: " + str(Global.is_fog).to_lower()
	$Lightning.text = "Lightning: " + str(Global.is_lightning).to_lower()
	if Global.is_easy:
		$Difficult.text = "Difficult: easy"
	else:
		$Difficult.text = "Difficult: hard"


func _on_button_back_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


static func _on_button_change_pressed() -> void:
	match Global.move_mode:
		Global.MOVE_MODE.TOUCH:
			Global.move_mode = Global.MOVE_MODE.VIRTUAL_JOYSTICK
		Global.MOVE_MODE.VIRTUAL_JOYSTICK:
			Global.move_mode = Global.MOVE_MODE.KEYBOARD
		Global.MOVE_MODE.KEYBOARD:
			Global.move_mode = Global.MOVE_MODE.KEYBOARD_MOUSE
		Global.MOVE_MODE.KEYBOARD_MOUSE:
			Global.move_mode = Global.MOVE_MODE.JOYSTICK
		Global.MOVE_MODE.JOYSTICK:
			Global.move_mode = Global.MOVE_MODE.DOUBLE_VIRTUAL_JOYSTICK
		Global.MOVE_MODE.DOUBLE_VIRTUAL_JOYSTICK:
			Global.move_mode = Global.MOVE_MODE.TOUCH
			

func _on_button_fog_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	Global.is_fog = not Global.is_fog


func _on_button_lightning_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	Global.is_lightning = not Global.is_lightning


func _on_button_difficult_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	Global.is_easy = not Global.is_easy
