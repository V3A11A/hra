extends AudioStreamPlayer2D

var last_position : float

func _physics_process(_delta: float) -> void:
	if last_position > get_playback_position():
		pitch_scale = randf_range(0.8, 1.2)
	
	last_position = get_playback_position()
