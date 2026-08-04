extends Node

func item_counting(item_count : Dictionary, delta : float) -> Dictionary:
	for i in item_count:
		
		if item_count[i] > 0:
			item_count[i] -= delta
			if item_count[i] <= 0:
				item_count[i] = -INF
		if item_count[i] == -INF:
			pass
			
	print(item_count)
	return item_count

func item_effecting(item_count : Dictionary, delta : float) -> void:
	pass
