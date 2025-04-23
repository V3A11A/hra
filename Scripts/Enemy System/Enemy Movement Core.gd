extends NavigationAgent2D

##WARNING assumes that its a child of an enemy!


@export var speed : int = 1000
@export var drag : float = 5



enum Targets {Spawn, Player, Away_From_Player}
var target : Targets = Targets.Player



@onready var player : CharacterBody2D = get_tree().get_root().get_node("Game/Player")
@onready var enemy : CharacterBody2D = $".."



func Update_Target(target : Targets) -> void:
	match target:
		Targets.Spawn:
			pass#target_position = target_position
		Targets.Player:
			target_position = player.global_position



func _physics_process(delta: float) -> void:
	Update_Target(target)
	Calculate_Movement(delta)



func Calculate_Movement(delta : float) -> void:
	var direction : Vector2 = (get_next_path_position() - enemy.global_position).normalized()
	
	enemy.velocity = enemy.velocity.lerp(direction * speed, delta * 5)
	enemy.move_and_slide()
