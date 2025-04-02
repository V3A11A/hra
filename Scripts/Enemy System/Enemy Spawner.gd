extends Node2D

@onready var enemy_spawn_location : Node = get_tree().get_root().get_node("Game/Enemies")



func Spawn(enemy : CharacterBody2D, difficulty_of_enemy : int):
	enemy.difficulty = difficulty_of_enemy
	enemy.global_position = global_position
	enemy_spawn_location.add_child(enemy)
