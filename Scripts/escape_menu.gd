extends Node2D

@onready var audio_manager: Node = $"../../AudioManager"
@onready var game: Node2D = $"../../Game"
@onready var main_menu: Node2D = $"../MainMenu"
@onready var money_label: RichTextLabel = $"../../Game/Player/EconomySystem/CanvasLayer/Money"
@onready var hpbar: CanvasLayer = $"../../Game/Player/UI"
var inGame: bool = false



func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Menu") and inGame:
		toggle_menu()

func _on_back_to_game_pressed() -> void:
	$click.play()
	resume_game()

func _on_options_pressed() -> void:
	$click.play()
	toggle_options()

func _on_exit_pressed() -> void:
	$click.play()
	exit_pause_menu()
	
	

# For better understanding
func toggle_menu():
	self.visible = !self.visible
	$CanvasLayer.visible = !$CanvasLayer.visible
	get_tree().paused = !get_tree().paused
	
func toggle_options():
	self.hide()
	inGame = false
	$"../Options".show()
	hpbar.visible = false
	$CanvasLayer.hide()
	
func resume_game():
	self.hide()
	get_tree().paused = false
	$CanvasLayer.hide()
	hpbar.visible = true

func exit_pause_menu():
	audio_manager.crossfire()
	self.hide()
	game.process_mode = Node.PROCESS_MODE_DISABLED
	main_menu.process_mode = Node.PROCESS_MODE_INHERIT
	main_menu.show()
	$CanvasLayer.hide()
	game.hide()
	money_label.hide()
	inGame = false
	get_tree().paused = false
	hpbar.visible = false
	main_menu.inMenu = true
