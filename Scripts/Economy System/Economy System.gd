extends Node

@onready var money_label: RichTextLabel = $CanvasLayer/Money



var money:int
var upgrades = {
	0: {
		"Name": "Sword",
		"Detail": "Damage up",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [1, 2, 3, 4, 5]
	}, 
	1: {
		"Name": "Sword",
		"Detail": "Area size up",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [4.2, 5.3, 6.7, 8, 9]
	}, 
	2: {
		"Name": "Sword",
		"Detail": "Attack Speed up",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [0.5, 2, 3.9, 5.5, 7.5]
	}, 
	3:{
		"Name": "Gun",
		"Detail": "Damage up",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [1, 2, 3, 4, 5]
	}, 
	4: {
		"Name": "Gun",
		"Detail": "Firerate up",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [0.18, 0.16, 0.14, 0.12, 0.1]
	}, 
	5: {
		"Name": "Boots",
		"Detail": "Movement speed up",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [1.5, 2, 2.5, 3, 3.5]
	}, 
	6: {
		"Name": "Potion",
		"Detail": "HP heal",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [2, 2.7, 3, 3.9, 4.7]
	}, 
	7: {
		"Name": "Magic Potion",
		"Detail": "HP max heal up",
		"Cost": [1, 2, 3, 4, 5],
		"Level": 0,
		"Value": [1, 2, 3, 4, 5]
	}
}

func _process(delta: float) -> void:
	money_label.text = "[wave]"+str(money)+"$"

func AddMoney(amount:int):
	money += amount
