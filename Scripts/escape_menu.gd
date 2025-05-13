extends Node2D

@onready var main_menu: Node2D = $"../MainMenu"
@onready var game: Node2D = $"../../Game"

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Menu"):
		self.visible = !self.visible

func _on_back_to_game_pressed() -> void:
	self.hide()


func _on_options_pressed() -> void:
	$"../Options".show()
	self.hide()

func _on_exit_pressed() -> void:
	main_menu.show()
	self.hide()
	game.hide()
	game.process_mode = Node.PROCESS_MODE_DISABLED
	main_menu.process_mode = Node.PROCESS_MODE_INHERIT
