extends Node2D

@onready var camera: Camera2D = $"../../Game/Player/Camera2D"
@onready var main_menu: Node2D = $"../MainMenu"
@onready var hpbar: CanvasLayer = $"../../Game/Player/UI"
@onready var escape_menu: Node2D = $"../EscapeMenu"
var smallCursor = load("res://Sprites/smallCursor.png")
var medCursor = load("res://Sprites/medCursor.png")
var defCursor = load("res://Sprites/defCursor.png")


func _on_back_pressed() -> void:
	$click.play()
	self.hide()
	if !main_menu.inMenu:
		$"../EscapeMenu/CanvasLayer".show()
		escape_menu.inGame = true
		escape_menu.show()
		hpbar.show()
	else:
		main_menu.link_button.show()

func _on_volume_slider_value_changed(value: float) -> void:
	$click.play()
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_toggle_screen_shake_toggled(toggled_on: bool) -> void:
	$click.play()
	camera.allowShake = toggled_on

func _on_toggle_full_screen_toggled(toggled_on: bool) -> void:
	$click.play()
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_h_slider_value_changed(value: float) -> void:
	$click.play()
	if value == 1:
		Input.set_custom_mouse_cursor(smallCursor, Input.CURSOR_ARROW, Vector2(8, 8))
	if value == 2:
		Input.set_custom_mouse_cursor(medCursor, Input.CURSOR_ARROW, Vector2(16, 16))
	if value == 3:
		Input.set_custom_mouse_cursor(defCursor, Input.CURSOR_ARROW, Vector2(32, 32))
