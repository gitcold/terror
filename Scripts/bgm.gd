extends AudioStreamPlayer

@export var playlist: Array[AudioStream] = []

func _ready():
	randomize()
	
	if playlist.is_empty():
		print("Warning: The music list is empty!")
		return
	
	play_random_music()


func play_random_music():
	var random_index = randi_range(0, playlist.size() - 1)
	stream = playlist[random_index]
	play()

func _on_finished() -> void:
	play_random_music()
