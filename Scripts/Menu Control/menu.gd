extends Node2D

@onready var game: Node2D = $"../Game"
const OPTIONS = preload("res://Scenes/Options.tscn")

func _on_play_pressed() -> void:
	game.show()
	game.process_mode = Node.PROCESS_MODE_INHERIT
	self.hide()
	self.process_mode = Node.PROCESS_MODE_DISABLED


func _on_options_pressed() -> void:
	$"../CanvasLayer/Options".show()


func _on_quit_pressed() -> void:
	get_tree().quit()
