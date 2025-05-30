extends Node

@onready var movement: CollisionShape2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"



func _physics_process(delta: float) -> void:
	if movement.run_velocity == Vector2.ZERO:
		animated_sprite_2d.set_frame_and_progress(0, 0.0)
		$AnimationPlayer.stop()
	else:
		animated_sprite_2d.animation
		$AnimationPlayer.play("walk")
		
