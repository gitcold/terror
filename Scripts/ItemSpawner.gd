extends Node2D

var spawn_data : Array[Dictionary] = [
	{
		"count"=Vector2(12, 17),
		"distance"=50,
		"name"="BulletSpeeder",
		"first_count"=Vector2(12, 15),
	},
	{
		"count"=Vector2(20, 25),
		"distance"=50,
		"name"="HealthBag",
		"first_count"=Vector2(20, 25),
	},
	{
		"count"=Vector2(12, 15),
		"distance"=50,
		"name"="BulletBigger",
		"first_count"=Vector2(15, 20),
	},
	{
		"count"=Vector2(15, 17),
		"distance"=50,
		"name"="Laser",
		"first_count"=Vector2(20, 25),
	},
	{
		"count"=Vector2(12, 45),
		"distance"=50,
		"name"="Sunshine",
		"first_count"=Vector2(0, 1),
	},
	{
		"count"=Vector2(35, 55),
		"distance"=50,
		"name"="ElectricBead",
		"first_count"=Vector2(30, 45),
	},
]

var spawn_count : Array
var enemy_num = spawn_data.size()

func _ready() -> void:
	randomize()
	for i in range(enemy_num):
		var count_min = spawn_data[i]["first_count"].x
		var count_max = spawn_data[i]["first_count"].y
		spawn_count.append(randf_range(count_min,count_max))
	if not Global.is_fog:
		spawn_count[4] = INF
	
func _process(delta: float) -> void:
	for i in range(enemy_num):
		spawn_item(i,delta)
		
func spawn_item(i : float, delta : float) -> void:
	spawn_count[i] -= delta
	if spawn_count[i] <= 0:
		var count_min = spawn_data[i]["count"].x
		var count_max = spawn_data[i]["count"].y
		spawn_count[i] = randf_range(count_min,count_max)
		position = Vector2(randf_range(0,800),randf_range(0,480))
		var player_pos = get_tree().current_scene.get_player_pos()
		var distance = position.distance_to(player_pos)
		while distance <= spawn_data[i]["distance"]:
			position = Vector2(randf_range(0,800),randf_range(0,480))
			distance = position.distance_to(player_pos)
		var enemy_scene: PackedScene = load("res://Scenes/item/" + spawn_data[i]["name"] + ".tscn")
		var enemy_node = enemy_scene.instantiate()
		enemy_node.position = position
		get_tree().current_scene.add_child(enemy_node)
