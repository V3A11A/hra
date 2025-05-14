extends Node2D

var cameraShakeEnable: bool = false
var fullscreen: bool = false

func _on_back_pressed() -> void:
	self.hide()
	if $"../EscapeMenu".inGame:
		$"../EscapeMenu".show()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_toggle_screen_shake_toggled(toggled_on: bool) -> void:
	cameraShakeEnable = toggled_on
	$"../../Game/Player/Camera2D".allowShake = cameraShakeEnable


func _on_toggle_full_screen_toggled(toggled_on: bool) -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = !fullscreen
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		fullscreen = !fullscreen
