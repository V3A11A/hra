extends Node2D

@onready var game: Node2D = $"../../Game"
@onready var main_menu: Node2D = $"../MainMenu"
var inGame: bool = false

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Menu") and inGame:
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused

func _on_back_to_game_pressed() -> void:
	self.hide()
	get_tree().paused = false
	

func _on_options_pressed() -> void:
	inGame = false
	$"../Options".show()
	self.hide()


func _on_exit_pressed() -> void:
	main_menu.show()
	self.hide()
	game.hide()
	game.process_mode = Node.PROCESS_MODE_DISABLED
	main_menu.process_mode = Node.PROCESS_MODE_INHERIT
	inGame = false
	get_tree().paused = false
	main_menu.inMenu = true
