extends Node2D
@onready var animation_player: AnimationPlayer = $TheDoor/AnimationPlayer
@onready var open_timer: Timer = $OpenTimer
@onready var close_timer: Timer = $CloseTimer
#self.queue_free()
var animation_started: bool = false
var bodyInside: bool = false

func _on_open_area_body_entered(body: Node2D) -> void:
	bodyInside = true
	if !animation_started and bodyInside:
		animation_started = !animation_started
		animation_player.play("flash")
		open_timer.start()
	
	
func _on_open_timer_timeout() -> void:
	animation_player.play("open")
	close_timer.start()
	open_timer.stop()
	
	
func _on_close_timer_timeout() -> void:
	if !bodyInside:
		animation_player.play("close")
		close_timer.stop()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close":
		animation_started = !animation_started


func _on_open_area_body_exited(body: Node2D) -> void:
	bodyInside = false
