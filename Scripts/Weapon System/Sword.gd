extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func Attack() -> void:
	if animation_player.get_queue().size() < 2:
		animation_player.queue("attack")
