extends CharacterBody2D

enum MOVE_MODE {
	TOUCH,
	JOYSTICK
}

var move_mode : MOVE_MODE = MOVE_MODE.TOUCH
var move_speed : float = 250
var move_speed_far : float = 0.033
var move_speed_near : float = move_area_r ** 2 * 3 * move_speed_far
var move_area_r : float = 35
var bullet_offset : float = 13
var bullet_size : float = 1
@export var bullet_scene : PackedScene
@export var laser_scene : PackedScene
@export var electric_bead_scene : PackedScene
@export var bullet_type : PackedScene
@export var joystick : VirtualJoystick
@export var polygon : Polygon2D
@export var timer : Timer
var hp : float = 0
const HP : float = 5
const HP_MAX : float = 5
var invincible_second : float = 0
const INVINCIBLE_SECOND : float = 4
@export var item_count : Dictionary
var item_effect = preload("res://Scripts/player/item_effect.gd")


func _ready() -> void:
	timer.wait_time = 0.4
	hp = HP
	bullet_type = bullet_scene
	match move_mode:
		MOVE_MODE.TOUCH:
			joystick.visible = false
		MOVE_MODE.JOYSTICK:
			joystick.visible = true
	
	item_count = {
		"BulletSpeeder": 0,
		"HealthBag": 0,
		"BulletBigger": 0,
		"Laser": 0,
		"Sunshine": 0,
		"ElectricBead": 0,
		}
	
	
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
				var move_area_distance = move_area_r ** 2
				if distance >= move_area_distance:
					var theta = rotation
					if distance >= move_area_distance * 3:
						velocity += Vector2(cos(theta), sin(theta)) * distance * move_speed_far
					else:
						velocity += Vector2(cos(theta), sin(theta)) * move_speed_near
					
		MOVE_MODE.JOYSTICK:
			look_at(position + velocity)
	move_and_slide()
	#无敌帧
	if invincible_second > 0:
		invincible_second -= delta
	polygon.modulate.a = cos(invincible_second * 12)
	#item倒计时
	item_effect.item_effecting(self)
	item_effect.item_counting(self, delta)
	
	
func _on_fire() -> void:
	var bullet_node = bullet_type.instantiate()
	var theta = rotation
	var bullet_direction = Vector2(cos(theta), sin(theta))
	bullet_node.direction = bullet_direction
	bullet_node.rotation = rotation
	bullet_node.position = position + bullet_direction * bullet_offset
	bullet_node.scale *= Vector2(bullet_size, bullet_size)
	get_tree().current_scene.add_child(bullet_node)


func _on_move_mode_change() -> void:
	match move_mode:
		MOVE_MODE.TOUCH:
			move_mode = MOVE_MODE.JOYSTICK
			joystick.visible = true
		MOVE_MODE.JOYSTICK:
			move_mode = MOVE_MODE.TOUCH
			joystick.visible = false
			
