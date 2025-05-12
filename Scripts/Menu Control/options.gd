extends Node2D

var cameraShakeEnable: bool = true

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	self.queue_free()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_toggle_screen_shake_toggled(toggled_on: bool) -> void:
	cameraShakeEnable = toggled_on
