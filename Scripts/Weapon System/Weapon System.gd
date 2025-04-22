extends Node2D

@onready var player: CharacterBody2D = $"../.."
@onready var anchor: Node2D = $".."
@onready var movement: CollisionShape2D = $"../../Movement"

@onready var melee: Node2D = $Melee
@onready var ranged: Node2D = $Ranged

@onready var melee_cd: Timer = $"melee CD"
@onready var ranged_cd: Timer = $"ranged CD"




func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Melee_Attack") and ranged_cd.is_stopped():
		Attack_With(true)
		
	if Input.is_action_just_pressed("Ranged_Attack") and melee_cd.is_stopped():
		Attack_With(false)


func Attack_With(type_melee : bool) -> void:
	if type_melee:
		if melee.get_child(0) and melee_cd.is_stopped():
			melee_cd.start(melee.get_child(0).attack_CD)
			melee.get_child(0).Attack()
			printt("melee:", Time.get_ticks_msec() / 1000.0)
		return
	
	if ranged.get_child(0) and ranged_cd.is_stopped():
		ranged_cd.start(ranged.get_child(0).attack_CD)
		ranged.get_child(0).Attack()
		printt("ranged:", Time.get_ticks_msec() / 1000.0)



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




func _on_melee_cd_timeout() -> void:
	if Input.is_action_pressed("Melee_Attack"):
		Attack_With(true)
		return
	
	if Input.is_action_pressed("Ranged_Attack"):
		Attack_With(false)


func _on_ranged_cd_timeout() -> void:
	if Input.is_action_pressed("Ranged_Attack"):
		Attack_With(false)
		return
	
	if Input.is_action_pressed("Melee_Attack"):
		Attack_With(true)
