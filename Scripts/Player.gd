extends CharacterBody2D

@export var move_speed : float = 250
@export var move_speed_log : float = 200
@export var bullet_scene : PackedScene
@export var move_area_r : float = 35

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * move_speed
	
	#朝向鼠标
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var local_mouse_pos = to_local(get_global_mouse_position())
		var distance = (local_mouse_pos.x ** 2 + local_mouse_pos.y ** 2 )
		if distance >= (move_area_r ** 2):
			var theta = rotation
			velocity += Vector2(cos(theta), sin(theta)) * move_speed_log * (log(distance/5000+2.8) / log(2.8))
		
	move_and_slide()
	

func _on_fire() -> void:
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position
	var theta = rotation
	var bullet_direction = Vector2(cos(theta), sin(theta))
	bullet_node.direction = bullet_direction
	bullet_node.rotation = rotation
	get_tree().current_scene.add_child(bullet_node)
