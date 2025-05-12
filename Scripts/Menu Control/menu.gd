extends Node2D

const GAME = preload("res://Scenes/Game.tscn")
const OPTIONS = preload("res://Scenes/Options.tscn")

func _on_play_pressed() -> void:
	get_parent().add_child(GAME.instantiate())
	self.queue_free()


func _on_options_pressed() -> void:
	get_parent().add_child(OPTIONS.instantiate())


func _on_quit_pressed() -> void:
	get_tree().quit()
