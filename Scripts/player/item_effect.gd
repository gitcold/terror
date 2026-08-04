extends Node

static func item_counting(player : CharacterBody2D, delta : float) -> void:
	for i in player.item_count:
		if player.item_count[i] > 0:
			player.item_count[i] -= delta
			if player.item_count[i] <= 0:
				player.item_count[i] = -INF
		if player.item_count[i] == -INF:
			match i:
				"BulletSpeeder":
					player.timer.wait_time = 0.4
				"HealthBag":
					if player.hp < player.HP_MAX:
						player.hp += 1
				_:
					pass
			player.item_count[i] = 0

static func item_effecting(player : CharacterBody2D) -> void:
	for i in player.item_count:
		if player.item_count[i] > 0:
			match i:
				"BulletSpeeder":
					player.timer.wait_time = 0.1
				"HealthBag":
					pass
				_:
					pass
