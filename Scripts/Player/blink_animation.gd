extends AnimationPlayer


@export var amount_of_flash : float:
	set(value):
		amount_of_flash = value
		$"..".material.set_shader_parameter("flash_color", amount_of_flash)



#func _physics_process(delta: float) -> void:
	#$"..".material.set_shader_parameter("flash_color", amount_of_flash)
	#printerr($"..".material.get_shader_parameter("flash_color"))



func _ready() -> void:
	$"..".material.set_shader_parameter("flash_color", 1)


func _on_health_system_damage_taken(amount: int) -> void:
	play("flash")
