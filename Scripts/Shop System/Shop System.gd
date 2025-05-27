extends CanvasLayer
@onready var shop_animation: AnimationPlayer = $"Shop Animation"
@onready var exit: Button = $Exit
var decide = 0
@onready var economy_system : Node = get_tree().get_root().get_node("Main/Game/Player/EconomySystem")



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shop_Menu"):
		get_tree().paused = true
		shop_animation.play("moveIn")
		
	
func _on_exit_pressed() -> void:
	shop_animation.play("moveDown")
	get_tree().paused = false
	
func changeItems():
	get_node("Control/Name").text = economy_system.upgrades[decide]["Name"]
	get_node("Control/Detail").text = economy_system.upgrades[decide]["Detail"]
	get_node("Control/Detail").text += "\nCost: " + str(economy_system.upgrades[decide]["Cost"])
	

func _on_left_pressed() -> void:
	if decide == 0:
		decide = 7
		changeItems()
	else:
		decide -= 1
		changeItems()


func _on_right_pressed() -> void:
	if decide == 7:
		decide = 0
		changeItems()
	else:
		decide += 1
		changeItems()


func _on_buy_pressed() -> void:
	pass
