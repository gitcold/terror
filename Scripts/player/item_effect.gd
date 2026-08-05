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
				"BulletBigger":
					player.bullet_size = 1
					player.bullet_offset = 13
				"Laser":
					player.bullet_type = player.bullet_scene
					player.bullet_offset = 13
				"Sunshine":
					pass
				"ElectricBead":
					player.bullet_type = player.bullet_scene
					player.bullet_offset = 13
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
				"BulletBigger":
					player.bullet_size = 3
					player.bullet_offset = 19
				"Laser":
					player.bullet_type = player.laser_scene
					player.bullet_offset = 19
				"Sunshine":
					pass
				"ElectricBead":
					player.bullet_type = player.electric_bead_scene
					player.bullet_offset = 19
				_:
					pass
