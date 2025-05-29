extends Node

const mute := -30.0
const default_music_db := 0.0
const fade_time := 2.0

var current_music_player: AudioStreamPlayer

@onready var menu_song: AudioStreamPlayer = $MenuSong
@onready var game_song: AudioStreamPlayer = $GameSong


func _ready() -> void:
	AudioServer.set_bus_volume_db(0, 2.5)
	current_music_player = menu_song
	current_music_player.play()


func fade_in(track: AudioStream) -> void:
	current_music_player.stream = track
	current_music_player.volume_db = mute
	current_music_player.play()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(current_music_player, "volume_db", default_music_db, fade_time)


func fade_out() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(current_music_player, "volume_db", mute, fade_time)
	
	
func crossfire() -> void:
	fade_out()
	current_music_player = menu_song if current_music_player == game_song else game_song
	fade_in(current_music_player.stream)
