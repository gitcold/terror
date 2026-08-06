extends PointLight2D

var is_light : bool = false

func _process(delta: float) -> void:
	if not is_light:
		energy += delta * 9
		if energy > 1:
			energy = 1
			is_light = true
	else:
		energy -= delta * 9 / 17
	print(energy)


func _on_timer_timeout() -> void:
	queue_free()
