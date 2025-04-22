extends CharacterBody2D

var difficulty : int = 1



var health : int = 10:
	set(value):
		health = value
		if health < 0:
			queue_free()



@onready var wave_system: Node = get_tree().get_root().get_node("Game/Wave System")



func Take_Damage(amount : int) -> void:
	health -= amount



func _exit_tree() -> void:
	wave_system.enemies_left_in_wave.erase(difficulty)
	wave_system.enemies_left_in_wave = wave_system.enemies_left_in_wave #for set() triggering
