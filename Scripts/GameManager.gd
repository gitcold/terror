extends Node2D

@export var score : float = 0
@export var player : CharacterBody2D
@export var label_hp : Label
@export var label_score : Label
var is_lose : bool = false
var is_pause : bool = false

func get_player_pos() -> Vector2:
	return player.position

func _process(delta: float) -> void:
	label_hp.text = "HP: " + str(int(player.hp))
	label_score.text = "Score: " + str(int(score))
	print(score)
	if player.hp <= 0:
		is_lose = true
		$UI/Lose.visible = true
	if not is_lose:
		score += delta
	
func attack_player() -> void:
	if is_lose:
		return
	if player.invincible_second <= 0:
		player.hp -= 1
		player.invincible_second = player.INVINCIBLE_SECOND


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_button_pause_pressed() -> void:
	if is_pause:
		is_pause = false
		get_tree().paused = false
	else:
		is_pause = true
		get_tree().paused = true
