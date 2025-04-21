extends CharacterBody2D

var direction : Vector2
var bullet_speed : int = 2000

func _physics_process(_delta: float) -> void:
	velocity = direction * bullet_speed
	
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()
