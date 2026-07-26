extends Node2D

@export var score : int = 0
@export var player : CharacterBody2D
@export var label_hp : Label

func get_player_pos() -> Vector2:
	return player.position

func _process(delta: float) -> void:
	label_hp.text = "HP: " + str(player.hp)
	
func attack_player() -> void:
	if player.invincible_frame == 0:
		player.hp -= 1
		player.invincible_frame = player.INVINCIBLE_FRAME
