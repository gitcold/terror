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
					player.light.scale = Vector2(8, 8)
					player.light_x = 0
				"ElectricBead":
					player.bullet_type = player.bullet_scene
					player.bullet_offset = 13
			player.item_count[i] = 0
		
static func item_effecting(player : CharacterBody2D, delta : float) -> void:
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
					var count = player.item_count[i]
					if count > 3 and player.light.scale.x < 32:
						if player.light_x <= 0:
							player.light_x = (32 - player.light.scale.x) * 0.4
							if (32 - player.light.scale.x) < 2:
								player.light_x = (32 - 2) * 0.8
					if player.light.scale.x > 32:
						player.light_x = 0
						player.light.scale = Vector2(32, 32)
					if count <= 3 and player.light.scale.x > 8:
						player.light_x = -(player.light.scale.x - 8) * 1.3
						if (player.light.scale.x - 8) < 3:
							player.light_x = -3 * 1.3
					if player.light.scale.x < 8:
						player.light_x = 0
						player.light.scale = Vector2(8, 8)
					if count <= 0.2:
						player.light.scale = Vector2(8, 8)
				"ElectricBead":
					player.bullet_type = player.electric_bead_scene
					player.bullet_offset = 19
				
