extends AnimationPlayer


@export var amount_of_flash : float:
	set(value):
		amount_of_flash = value
		$"..".material.set_shader_parameter("flash_value", amount_of_flash)



func _physics_process(delta: float) -> void:
	$"..".material.set_shader_parameter("flash_value", amount_of_flash)


func _on_health_system_damage_taken(amount: int) -> void:
	play("flash")
