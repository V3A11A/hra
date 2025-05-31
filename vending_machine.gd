extends Node2D

@onready var shop_animation: AnimationPlayer = $"../../Shop System/Shop Animation"
@onready var shop_system: CanvasLayer = $"Shop System"
var player_inside = false
@onready var click_this: Sprite2D = $ClickThis


func _on_shop_area_body_entered(body: Node2D) -> void:
	player_inside = true
	click_this.show()
	
func _on_shop_area_body_exited(body: Node2D) -> void:
	player_inside = false
	click_this.hide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("Shop_Menu") and player_inside:
		get_tree().paused = true
		shop_animation.play("moveIn")
		
