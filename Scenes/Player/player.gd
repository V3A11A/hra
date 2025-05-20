extends CharacterBody2D


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _on_health_system_obliterate() -> void:
	pass #Game over screen, pánové! 🫡
