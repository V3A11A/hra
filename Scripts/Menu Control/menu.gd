extends Node2D

@onready var audio_manager: Node = $"../../AudioManager"
@onready var hpbar: CanvasLayer = $"../../Game/Player/UI"
@onready var game: Node2D = $"../../Game"
@onready var escape_menu: Node2D = $"../EscapeMenu"
@onready var canvas_layer: CanvasLayer = $"../../Game/Player/EconomySystem/CanvasLayer"
@onready var link_button: LinkButton = $LinkButton
var inMenu: bool = true

func _on_play_pressed() -> void:
	$click.play()
	start_game()
	configure_processes()
	update_ui()
	
func _on_options_pressed() -> void:
	$click.play()
	link_button.hide()
	$"../Options".show()

func _on_quit_pressed() -> void:
	$click.play()
	await $click.finished
	get_tree().quit()



# Updated for better understanding
func start_game():
	$click.play()
	audio_manager.crossfire() # Fades out Menu music and Fades in game music in
	game.show()
	inMenu = false
	escape_menu.inGame = true
	
func configure_processes() -> void:
	game.process_mode = Node.PROCESS_MODE_INHERIT
	self.hide()
	self.process_mode = Node.PROCESS_MODE_DISABLED
	link_button.hide()
	
func update_ui():
	canvas_layer.show()
	hpbar.show()
	
