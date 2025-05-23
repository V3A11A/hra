extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $Area2D



var attack_CD : float = 0.5

var damage : int = 5


func Attack() -> void:
	if animation_player.get_queue().size() < 2:
		animation_player.queue("attack")


func Scan_Hurtbox() -> void:
	for i : PhysicsBody2D in area_2d.get_overlapping_bodies():
		i.health_system.Take_Damage(damage)
