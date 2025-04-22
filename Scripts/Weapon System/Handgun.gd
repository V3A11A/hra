extends Node2D

const BULLET = preload("res://Scenes/Weapon System/Bullet.tscn")



@onready var weapon_system: Node2D = $"../.."
@onready var bullets: Node = $"../../Bullets"

@onready var animation_player: AnimationPlayer = $AnimationPlayer



var attack_CD : float = 0.2

var damage : int = 2


func Attack() -> void:
	if animation_player.get_queue().size() < 2:
		animation_player.queue("attack")


func Shoot() -> void:
	bullets.add_child(BULLET.instantiate())
	bullets.get_child(-1).global_position = weapon_system.player.global_position
	bullets.get_child(-1).direction = Vector2(weapon_system.get_global_mouse_position() - weapon_system.player.global_position).normalized()
	bullets.get_child(-1).damage = damage
