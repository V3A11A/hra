extends Node2D



func _on_quit_pressed() -> void:
	$click.play()
	get_tree().quit()
