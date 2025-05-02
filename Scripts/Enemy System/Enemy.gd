extends CharacterBody2D


var difficulty : int = 1



@onready var wave_system: Node = get_tree().get_root().get_node("Game/Wave System")
@onready var health_system: Node = $"Health System"



func _exit_tree() -> void:
w	wave_system.enemies_left_in_wave.erase(difficulty)
	wave_system.enemies_left_in_wave = wave_system.enemies_left_in_wave #for set() triggering


func _on_health_system_obliterate() -> void:
	queue_free()
