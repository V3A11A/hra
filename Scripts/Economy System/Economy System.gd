extends Node

@onready var money_label: RichTextLabel = $CanvasLayer/Money



var money:int
var upgrades = {
	0: {
		"Name": "Sword",
		"Detail": "Damage up",
		"Cost": 1
	}, 
	1: {
		"Name": "Sword",
		"Detail": "Area size up",
		"Cost": 1
	}, 
	2: {
		"Name": "Sword",
		"Detail": "Attack Speed up",
		"Cost": 1
	}, 
	3:{
		"Name": "Weapon",
		"Detail": "Damage up",
		"Cost": 1
	}, 
	4: {
		"Name": "Weapon",
		"Detail": "Firerate up",
		"Cost": 1
	}, 
	5: {
		"Name": "Boots",
		"Detail": "Movement speed up",
		"Cost": 1
	}, 
	6: {
		"Name": "Potion",
		"Detail": "HP heal",
		"Cost": 1
	}, 
	7: {
		"Name": "Magic Potion",
		"Detail": "HP max heal up",
		"Cost": 1
	}
}

func _process(delta: float) -> void:
	money_label.text = "[wave]Money: "+str(money)

func AddMoney(amount:int):
	money += amount
