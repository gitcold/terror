extends Node2D

var spawn_data : Array[Dictionary] = [
	{
		"count"=Vector2(0.1, 2),
		"distance"=150,
		"name"="OrangeBall",
		"first_count"=3,
	},
	{
		"count"=Vector2(2, 4),
		"distance"=150,
		"name"="CyanSquare",
		"first_count"=4,
	},
	{
		"count"=Vector2(8, 15),
		"distance"=200,
		"name"="BigYellow",
		"first_count"=15,
	},
]

var spawn_count : Array
var enemy_num = 3
var is_lose : bool = false

func _ready() -> void:
	randomize()
	for i in range(enemy_num):
		spawn_count.append(spawn_data[i]["first_count"]) 
	
func _process(delta: float) -> void:
	for i in range(enemy_num):
		spawn_enemy(i,delta)
		
func spawn_enemy(i : float, delta : float) -> void:
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
		var enemy_scene: PackedScene = load("res://Scenes/enemy/" + spawn_data[i]["name"] + ".tscn")
		var enemy_node = enemy_scene.instantiate()
		enemy_node.position = position
		get_tree().current_scene.add_child(enemy_node)
