extends Node2D

@onready var shop_animation: AnimationPlayer = $"../../Shop System/Shop Animation"
@onready var shop_system: CanvasLayer = $"../../Shop System"
var player_inside = false
@onready var click_this: Sprite2D = $ClickThis
@onready var escape_menu: Node2D = $"../../../CanvasLayer/EscapeMenu"

func _on_shop_area_body_entered(body: Node2D) -> void:
	player_inside = true
	click_this.show()

func _on_shop_area_body_exited(body: Node2D) -> void:
	player_inside = false
	click_this.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shop_Menu") and player_inside and !escape_menu.inPauseMenu:
		shop_system.inShop = !shop_system.inShop
		if shop_system.inShop:
			get_tree().paused = !get_tree().paused
			shop_animation.play("moveIn")
		else:
			get_tree().paused = !get_tree().paused
			shop_animation.play("moveDown")
