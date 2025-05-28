extends Node2D

func _on_open_area_body_entered(body: Node2D) -> void:
	self.queue_free()
