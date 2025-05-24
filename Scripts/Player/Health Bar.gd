extends Node2D

@export var health : Node

@onready var health_bar: TextureProgressBar = $"Health Bar"
@onready var damage_bar: TextureProgressBar = $"Damage Bar"
@onready var damage_timer: Timer = $"Damage Timer"
@onready var heal_bar: TextureProgressBar = $"Heal Bar"
@onready var text : RichTextLabel = $Text



func Change_Vigor():
	health_bar.max_value = health.max_health
	heal_bar.max_value = health.max_health
	damage_bar.max_value = health.max_health
	
	text.text = "[b]" + str(round(health.current_health * pow(10.0, 1)) / pow(10.0, 1)) + " / " + str(health.max_health)



var previous_health : float = 0
func Change_Health() -> void:
	if health_bar.value > damage_bar.value:
		damage_bar.value = health_bar.value
	
	
	if healthbar_tween: healthbar_tween.kill()
	if healbar_tween: healbar_tween.kill()
	
	
	Update_Health_Bar()
	Update_Heal_Bar()
	
	text.text = "[b]" + str(round(health.current_health * pow(10.0, 1)) / pow(10.0, 1)) + " / " + str(health.max_health)
	
	
	if is_equal_approx(signf(health.current_health - previous_health),-1):
		damage_timer.start()
	else:
		if is_zero_approx(health.current_health - previous_health) and not is_zero_approx(health.current_health):
			pass
		else:
			Update_Damage_Bar()
	
	previous_health = health.current_health


var healthbar_tween : Tween
func Update_Health_Bar() -> void:
	healthbar_tween = create_tween()
	healthbar_tween.set_ease(Tween.EASE_OUT)
	healthbar_tween.set_trans(Tween.TRANS_CUBIC)
	healthbar_tween.tween_property(health_bar, "value", health.current_health, 0.1)


var healbar_tween : Tween
func Update_Heal_Bar() -> void:
	healbar_tween = create_tween()
	healbar_tween.set_ease(Tween.EASE_OUT)
	healbar_tween.set_trans(Tween.TRANS_CUBIC)
	healbar_tween.tween_property(heal_bar, "value", health.current_health, 0.05)


var damage_tween : Tween
func Update_Damage_Bar() -> void:
	if health.current_health > damage_bar.value:
		damage_tween = create_tween()
		damage_tween.set_ease(Tween.EASE_OUT)
		damage_tween.set_trans(Tween.TRANS_CUBIC)
		damage_tween.tween_property(damage_bar, "value", health_bar.value, 0.1)
		return
	damage_tween = create_tween()
	damage_tween.set_ease(Tween.EASE_OUT)
	damage_tween.set_trans(Tween.TRANS_CUBIC)
	damage_tween.tween_property(damage_bar, "value", health.current_health, 0.5)



func _ready() -> void:
	Change_Vigor()
	Change_Health()
	
	health.Max_Health_Changed.connect(On_Health_OnVigorChanged)
	health.Damage_Taken.connect(On_Health_OnHealthChanged)
	health.Healed.connect(On_Health_OnHealthChanged)



func On_Health_OnVigorChanged(_amount : int) -> void:
	call_deferred("Change_Vigor")

func On_Health_OnHealthChanged(_amount : int) -> void:
	call_deferred("Change_Health")
