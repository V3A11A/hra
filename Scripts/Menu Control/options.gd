extends Node2D

var cameraShakeEnable: bool = true


func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Menu"):
		self.visible = !self.visible

func _on_back_pressed() -> void:
	self.hide()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_toggle_screen_shake_toggled(toggled_on: bool) -> void:
	cameraShakeEnable = toggled_on
