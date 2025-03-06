extends CharacterBody2D

const speed : int = 1000
const drag : float = 5



@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D





func Set_Target(target_position : Vector2) -> void:
	navigation_agent_2d.target_position = target_position



func _physics_process(delta: float) -> void:
	navigation_agent_2d.target_position = get_global_mouse_position() #TEST
	
	var direction : Vector2 = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	
	velocity = velocity.lerp(direction * speed, delta * 5)
	move_and_slide()
