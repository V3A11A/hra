extends Node2D

const ENEMY = preload("res://Scenes/Enemy System/Enemies/Enemy.tscn")



@onready var enemy_spawn_location : Node = get_tree().get_root().get_node("Game/Enemies")



func Spawn(enemy : CharacterBody2D):
	enemy_spawn_location.add_child(enemy)


#TEST
func _ready() -> void:
	for i in 1:
		await get_tree().create_timer(1).timeout
		Spawn(ENEMY.instantiate())
