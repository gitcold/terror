extends CharacterBody2D

enum MOVE_MODE {
	TOUCH,
	JOYSTICK
}

@export var move_mode : MOVE_MODE = MOVE_MODE.JOYSTICK
@export var move_speed : float = 250
@export var move_speed_log : float = 75
@export var bullet_scene : PackedScene
@export var move_area_r : float = 35
@export var joystick : VirtualJoystick

func _ready() -> void:
	match move_mode:
		MOVE_MODE.TOUCH:
			joystick.visible = false
		MOVE_MODE.JOYSTICK:
			joystick.visible = true
	
func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * move_speed
	match move_mode:
		MOVE_MODE.TOUCH:
			#朝向鼠标
			var mouse_pos = get_global_mouse_position()
			look_at(mouse_pos)
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				var local_mouse_pos = to_local(get_global_mouse_position())
				var distance = (local_mouse_pos.x ** 2 + local_mouse_pos.y ** 2 )
				if distance >= (move_area_r ** 2):
					var theta = rotation
					velocity += Vector2(cos(theta), sin(theta)) * move_speed_log * (log(distance/5000+1.3) / log(1.3))
					#velocity += Vector2(cos(theta), sin(theta)) * 1 * distance * 0.01
		MOVE_MODE.JOYSTICK:
			look_at(position + velocity)
	move_and_slide()
	

func _on_fire() -> void:
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position
	var theta = rotation
	var bullet_direction = Vector2(cos(theta), sin(theta))
	bullet_node.direction = bullet_direction
	bullet_node.rotation = rotation
	get_tree().current_scene.add_child(bullet_node)


func _on_move_mode_change() -> void:
	match move_mode:
		MOVE_MODE.TOUCH:
			move_mode = MOVE_MODE.JOYSTICK
			joystick.visible = true
		MOVE_MODE.JOYSTICK:
			move_mode = MOVE_MODE.TOUCH
			joystick.visible = false
			
