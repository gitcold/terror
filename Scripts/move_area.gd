extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_mouse_in_area() -> bool:
	# 把全局鼠标坐标转成Area2D的局部坐标
	
	# 用碰撞形状判断点是否在区域内
	return $CollisionShape2D.shape.collide_with_point(transform, local_mouse_pos)
