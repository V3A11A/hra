extends Node2D

@onready var audio_manager: Node = $"../../AudioManager"
@onready var money_label: RichTextLabel = $"../../Game/Player/EconomySystem/CanvasLayer/Money"
@onready var game: Node2D = $"../../Game"
var inMenu: bool = true

func _on_play_pressed() -> void:
	audio_manager.crossfire()
	game.show()
	game.process_mode = Node.PROCESS_MODE_INHERIT
	self.hide()
	self.process_mode = Node.PROCESS_MODE_DISABLED
	$"../EscapeMenu".inGame = true
	inMenu = false
	money_label.show()


func _on_options_pressed() -> void:
	$"../Options".show()


func _on_quit_pressed() -> void:
	get_tree().quit()
