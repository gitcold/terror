extends Node

func item_counting(item_count : Dictionary, delta : float, timer : Timer) -> void:
	for i in item_count:
		if item_count[i] > 0:
			item_count[i] -= delta
			if item_count[i] <= 0:
				item_count[i] = -INF
		if item_count[i] == -INF:
			match i:
				"BulletSpeeder":
					timer.wait_time = 0.4
				_:
					pass
			item_count[i] = 0
	print(item_count)

func item_effecting(item_count : Dictionary, delta : float, timer : Timer) -> void:
	for i in item_count:
		if item_count[i] > 0:
			match i:
				"BulletSpeeder":
					timer.wait_time = 0.1
				_:
					pass
