extends Node

signal Obliterate
signal Max_Health_Changed(amount : int)
signal Damage_Taken(amount : int)
signal Healed(amount : int)



@export var max_health : int = 10:
	set(value):
		max_health = maxi(value, 1)
		current_health = current_health
var current_health : int = max_health:
	set(value):
		current_health = clampi(value, 0, max_health)
		if current_health == 0:
			Obliterate.emit()

@export_range(0.05, 1, 0.05, "or_greter") var invincible_time : float = 0.5 ##seconds



@onready var invincible_timer: Timer = $"Invincible timer"



func Take_Damage(amount : int):
	print("i guess try")
	if amount < 0:
		current_health -= amount
		Healed.emit(amount)
		return
	
	if invincible_timer.is_stopped():
		current_health -= amount
		Damage_Taken.emit(amount)
		invincible_timer.start(invincible_time)
		print(self, current_health)


func Change_Max_Health(amount : int, heal_when_increased : bool = false):
	max_health += amount
	
	Max_Health_Changed.emit(amount)
	
	if amount > 0:
		if heal_when_increased:
			Take_Damage(-amount)
