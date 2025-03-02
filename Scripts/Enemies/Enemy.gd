extends CharacterBody2D


@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	velocity = navigation_agent_2d.get_next_path_position()
	move_and_slide()


@export var target_position : Vector2

func _ready() -> void:
	navigation_agent_2d.target_position = target_position
