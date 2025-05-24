extends CharacterBody2D

@onready var health_system: Node = $"Health System"
@onready var damage_collider: Area2D = $"Damage collider"
@onready var enemies: Node2D = $"../Enemies"



func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _on_health_system_obliterate() -> void:
	pass #Game over, pánové! 🫡




func _physics_process(delta: float) -> void:
	if damage_collider.has_overlapping_bodies():
		if health_system.invincible_timer.is_stopped():
			health_system.Take_Damage(damage_collider.get_overlapping_bodies()[0].damage)

			for i: CharacterBody2D in enemies.get_children():
				i.get_node("Push").play("Push")
