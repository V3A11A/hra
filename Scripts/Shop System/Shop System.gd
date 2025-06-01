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
@onready var sword_collisionshape = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Melee/Sword/Area2D/CollisionShape2D").shape
@onready var sword_sprite = get_tree().get_root().get_node("Main/Game/Player/Anchor/Weapon System/Melee/Sword/AnimatedSprite2D")
var inShop: bool = false
var sprites = []


@onready var Labelname: Label = $Control/Name
@onready var Labeldetail: Label = $Control/Detail

func _ready() -> void:
	for child in get_node("Control/Shop Items").get_children():
		if child is Sprite2D:
			sprites.append(child)
		
	print(decide)
	print(economy_system.upgrades[decide]["Name"])
	print(economy_system.upgrades[decide]["Detail"])
	print(economy_system.upgrades[decide]["Cost"])
	print(economy_system.upgrades[decide]["Value"])
	get_node("Control/Name").text = economy_system.upgrades[decide]["Name"]
	get_node("Control/Detail").text = economy_system.upgrades[decide]["Detail"]
	get_node("Control/Detail").text += "\nCost: " + str(economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]])



#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("Shop_Menu"):
#		get_tree().paused = true
#		shop_animation.play("moveIn")
		
	
func _on_exit_pressed() -> void:
	$click.play()
	shop_animation.play("moveDown")
	inShop = !inShop
	get_tree().paused = !get_tree().paused

	
func changeItems():
	get_node("Control/Name").text = economy_system.upgrades[decide]["Name"]
	get_node("Control/Detail").text = economy_system.upgrades[decide]["Detail"]
	if economy_system.upgrades[decide]["Level"] < (economy_system.upgrades[decide]["Cost"].size())-1:
		get_node("Control/Detail").text += "\nCost: " + str(economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]])
	else:
		get_node("Control/Detail").text = "You've reached maximal level on this upgrade"
	

func _on_left_pressed() -> void:
	$click.play()
	sprites[decide].hide()
	if decide == 0:
		decide = 7
		changeItems()
	else:
		decide -= 1
		changeItems()
	sprites[decide].show()


func _on_right_pressed() -> void:
	$click.play()
	sprites[decide].hide()
	if decide == 7:
		decide = 0
		changeItems()
	else:
		decide += 1
		changeItems()
	sprites[decide].show()


func _on_buy_pressed() -> void:
	$click.play()
	if economy_system.money >= economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]]:
		if economy_system.upgrades[decide]["Level"] <= (economy_system.upgrades[decide]["Cost"].size())-1:
			economy_system.money -= economy_system.upgrades[decide]["Cost"][economy_system.upgrades[decide]["Level"]]
			get_node("Control/Message").text = "Bought upgrade!"
			if economy_system.upgrades[decide]["Name"] == "Potion":
				health_system.Take_Damage(-(economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]))
			elif economy_system.upgrades[decide]["Name"] == "Magic Potion":
				health_system.Change_Max_Health(economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]], true)
			elif economy_system.upgrades[decide]["Name"] == "Boots":
				movement.speed_multiplier = economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]
			elif economy_system.upgrades[decide]["Name"] == "Gun":
				if economy_system.upgrades[decide]["Detail"] == "Damage up":
					handgun.damage = economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]
				elif economy_system.upgrades[decide]["Detail"] == "Firerate up":
					handgun.attack_CD = economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]
			elif economy_system.upgrades[decide]["Name"] == "Sword":
				if economy_system.upgrades[decide]["Detail"] == "Damage up":
					sword.damage = economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]
				elif economy_system.upgrades[decide]["Detail"] == "Area size up":
					sword_sprite.scale = Vector2(economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]], economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]])
					sword_collisionshape.extents *= economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]
				elif economy_system.upgrades[decide]["Detail"] == "Attack Speed up":
					sword.attack_CD = economy_system.upgrades[decide]["Value"][economy_system.upgrades[decide]["Level"]]
			economy_system.upgrades[decide]["Level"] += 1
			changeItems()
		else:
			get_node("Control/Message").text = "You've reached the maximal level for this upgrade"
		
	else:
		get_node("Control/Message").text = "Not enough funds"
