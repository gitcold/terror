extends Node2D
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().current_scene._on_button_pause_pressed()
	
