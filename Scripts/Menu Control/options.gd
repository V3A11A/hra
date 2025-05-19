extends Node2D

@onready var main_menu: Node2D = $"../MainMenu"

func _on_back_pressed() -> void:
	self.hide()
	if !main_menu.inMenu:
		$"../EscapeMenu".show()
		$"../EscapeMenu".inGame = true


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_toggle_screen_shake_toggled(toggled_on: bool) -> void:
	$"../../Game/Player/Camera2D".allowShake = toggled_on


func _on_toggle_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
