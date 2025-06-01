extends CanvasLayer
@onready var shop_animation: AnimationPlayer = $"Shop Animation"
@onready var exit: Button = $Exit
var decide = 0
@onready var economy_system : Node = get_tree().get_root().get_node("Main/Game/Player/EconomySystem")
@onready var handgun = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Ranged/Handgun")
@onready var sword = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Melee/Sword")
@onready var movement = get_tree().get_root().get_node("Main/Game/Player/Movement/Run")
@onready var health_system = get_tree().get_root().get_node("Main/Game/Player/Health System")
@onready var bullets = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Bullets")
@onready var hitbox = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Melee/Sword/Area2D/CollisionShape2D")
#@onready var sword_collisionshape = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Melee/Sword/Area2D/CollisionShape2D").shape
#@onready var sword_sprite = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Melee/Sword/AnimatedSprite2D")
var inShop: bool = false
@onready var sprites = get_node("Control/Shop Items").get_children()


@onready var Labelname: Label = $Control/Name
@onready var Labeldetail: Label = $Control/Detail

func _ready() -> void:
	get_node("Control/Name").text = economy_system.upgrades[decide]["Name"]
	get_node("Control/Detail").text = economy_system.upgrades[decide]["Detail"]
	get_node("Control/Detail").text += "\nCost: " + str(economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]])




func _on_exit_pressed() -> void:
	$click.play()
	shop_animation.play("moveDown")
	get_node("Control/Message").text = ""
	inShop = !inShop
	get_tree().paused = !get_tree().paused

	
func changeItems():
	get_node("Control/Name").text = economy_system.upgrades[decide]["Name"]
	get_node("Control/Detail").text = economy_system.upgrades[decide]["Detail"]
	if economy_system.upgrades[decide]["Level"] > economy_system.upgrades[decide]["Cost"].size() - 1:
		get_node("Control/Detail").text = "maximal level reached!"
		return
	get_node("Control/Detail").text += "\nCost: " + str(economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]])


func _on_left_pressed() -> void:
	$click.play()
	sprites[decide].hide()
	if decide == 0:
		decide = 7
		changeItems()
		get_node("Control/Message").text = ""
	else:
		decide -= 1
		changeItems()
		get_node("Control/Message").text = ""
	sprites[decide].show()


func _on_right_pressed() -> void:
	$click.play()
	sprites[decide].hide()
	if decide == 7:
		decide = 0
		changeItems()
		get_node("Control/Message").text = ""
	else:
		decide += 1
		changeItems()
		get_node("Control/Message").text = ""
	sprites[decide].show()


func _on_buy_pressed() -> void:
	$click.play()
	
	
	if economy_system.upgrades[decide]["Level"] > economy_system.upgrades[decide]["Cost"].size() - 1:
		#get_node("Control/Message").text = "You've reached the maximal level for this upgrade"
		return
		
	if not economy_system.money >= economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]]:
		get_node("Control/Message").text = "Not enough funds"
		return
	
	var cost : int = economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]]
	var value : int = economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]
	var item_name : String = economy_system.upgrades[decide]["Name"]
	
	
	economy_system.money -= cost
	get_node("Control/Message").text = "Bought upgrade!"
	
	if item_name == "Potion":
		health_system.Take_Damage(-value)
	elif item_name == "Magic Potion":
		health_system.Change_Max_Health(value, true)
	elif item_name == "Boots":
		movement.speed_multiplier = value
	elif item_name == "Gun":
		if economy_system.upgrades[decide]["Detail"] == "Damage up":
			handgun.damage = value
		elif economy_system.upgrades[decide]["Detail"] == "Firerate up":
			handgun.attack_CD = value
	elif item_name == "Sword":
		if economy_system.upgrades[decide]["Detail"] == "Damage up":
			sword.damage = value
		elif economy_system.upgrades[decide]["Detail"] == "Area size up":
			sword.scale = value*Vector2.ONE
		elif economy_system.upgrades[decide]["Detail"] == "Attack Speed up":
			sword.attack_CD = value
	
	economy_system.upgrades[decide]["Level"] += 1
	changeItems()
	
	
	#if economy_system.upgrades[decide]["Level"] > economy_system.upgrades[decide]["Cost"].size() - 1:
		#get_node("Control/Message").text = "You've reached the maximal level for this upgrade"
