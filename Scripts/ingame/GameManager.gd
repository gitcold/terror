extends Node2D

@export var score : float = 0
@export var player : CharacterBody2D
@export var label_hp : Label
@export var label_score : Label
@export var label_move_mode : Label
@export var label_difficult : Label
var is_lose : bool = false
var is_pause : bool = false
var WAV_PLAYER = preload("res://Scripts/play_wav.gd")
var wav_player
var current

func _ready() -> void:
	wav_player = WAV_PLAYER.new()
	current = get_tree().current_scene
	if Global.is_fog:
		$CanvasModulate.visible = true
	else:
		$CanvasModulate.visible = false

func get_player_pos() -> Vector2:
	return player.position

func _process(delta: float) -> void:
	label_hp.text = "HP: " + str(int(player.hp))
	label_score.text = "Score: " + str(int(score))
	label_move_mode.text = "Move Mode: " + str(Global.MOVE_MODE.find_key(Global.move_mode)).to_lower()
	if Global.is_easy:
		label_difficult.text = "Difficult: easy"
	else:
		label_difficult.text = "Difficult: hard"
	if player.hp <= 0:
		is_lose = true
		is_pause = true
		get_tree().paused = true
		$UI/Lose.visible = true
		$UI/Menu.visible = true
	if not is_lose and not is_pause:
		score += delta
	
func attack_player() -> void:
	if player.invincible_second <= 0:
		wav_player.play_wav("res://assets/wav/hurt.wav", current)
		player.hp -= 1
		player.invincible_second = player.INVINCIBLE_SECOND


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_button_pause_pressed() -> void:
	wav_player.play_wav("res://assets/wav/click.wav", current)
	if is_pause:
		is_pause = false
		get_tree().paused = false
		$UI/Pause.visible = false
		$UI/Menu.visible = false
	else:
		is_pause = true
		get_tree().paused = true
		$UI/Pause.visible = true
		$UI/Menu.visible = true

func give_player_item(item_name : String, item_count : float) -> void:
	wav_player.play_wav("res://assets/wav/pickupItem.wav", current)
	player.item_count[item_name] += item_count
