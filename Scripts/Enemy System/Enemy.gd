extends CharacterBody2D

@export var damage : int = 1
@export var difficulty : int = 1

var BloodStainTypes = [
	preload("res://Scenes/bloodstain_dump.tscn"),
	preload("res://Scenes/bloodstain_poly.tscn"),
	preload("res://Scenes/bloodstain_spray.tscn")
]

@onready var wave_system: Node = get_tree().get_root().get_node("Main/Game/Wave System")
@onready var health_system: Node = $"Health System"


func _exit_tree() -> void:
	wave_system.enemies_left_in_wave.erase(difficulty)
	wave_system.enemies_left_in_wave = wave_system.enemies_left_in_wave #for set() triggering


func _on_health_system_obliterate() -> void:
	set_collision_layer_value(2, false)
	await $hurt_sound.finished
	$"../../Player/UI/GameStats".enemies_killed += 1
	var randomnumber = randi() % BloodStainTypes.size()
	var blood = BloodStainTypes[randomnumber].instantiate()
	blood.position = position
	blood.rotation_degrees = randf() * 360
	blood.scale = Vector2.ONE * (0.25 + randf() * 0.4)
	get_tree().current_scene.get_node("Game/Map").add_child(blood)
	queue_free()

func _process(delta: float) -> void:
	look_at($"../../Player".position)
