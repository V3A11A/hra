extends Node2D

@onready var player: CharacterBody2D = $"../.."
@onready var anchor: Node2D = $".."
@onready var movement: CollisionShape2D = $"../../Movement"

@onready var melee: Node2D = $Melee
@onready var ranged: Node2D = $Ranged



func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Melee_Attack"):
		if melee.get_child(0):
			melee.get_child(0).Attack()
	if Input.is_action_just_pressed("Ranged_Attack"):
		if ranged.get_child(0):
			ranged.get_child(0).Attack()



func Change_Weapon(type_melee : bool, weapon : Node2D) -> void:
	if type_melee:
		if melee.get_child(0):
			melee.get_child(0).queue_free()
		melee.add_child(weapon.instantiate())
		return
	
	if ranged.get_child(0):
		ranged.get_child(0).queue_free()
	ranged.add_child(weapon.instantiate())


func _physics_process(_delta: float) -> void:
	var direction : Vector2 = Vector2(get_global_mouse_position() - player.global_position).normalized()
	anchor.look_at(player.global_position + direction)
