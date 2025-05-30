extends Node2D
@onready var animation_player: AnimationPlayer = $TheDoor/AnimationPlayer
@onready var open_timer: Timer = $OpenTimer
@onready var close_timer: Timer = $CloseTimer
#self.queue_free()
var animation_started: bool = false

func _on_open_area_body_entered(body: Node2D) -> void:
	if !animation_started:
		animation_started = !animation_started
		animation_player.play("flash")
		open_timer.start()
	
	
func _on_open_timer_timeout() -> void:
	animation_player.play("open")
	open_timer.stop()
