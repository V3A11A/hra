extends CharacterBody2D

var direction : Vector2
var bullet_speed : int = 2000

var damage : int

func _physics_process(_delta: float) -> void:
	velocity = direction * bullet_speed
	
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	print("TAKE THAT")
	body.health_system.Take_Damage(damage)
	queue_free()


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	queue_free()
