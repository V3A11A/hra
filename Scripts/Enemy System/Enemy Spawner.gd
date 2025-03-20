extends Node2D

@onready var enemy_spawn_location : Node = get_tree().get_root().get_node("Game/Enemies")



func Spawn(enemy : CharacterBody2D):
	enemy_spawn_location.add_child(enemy)
