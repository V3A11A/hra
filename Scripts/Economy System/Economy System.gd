extends Node

@onready var money_label: RichTextLabel = $CanvasLayer/Money



var money:int

func _process(delta: float) -> void:
	money_label.text = "[wave]Money: "+str(money)
	
func AddMoney(amount:int):
	print(amount)
	money += amount
