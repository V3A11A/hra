extends Node

@onready var money_label: RichTextLabel = $CanvasLayer/Money



var money:int
var upgrades = {
	0: {
		"Name": "Sword",
		"Detail": "Damage up",
		"Cost": [20, 40, 60, 80, 100],
		"Level": 0,
		"Value": [7, 9, 11, 13, 15]
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
		"Cost": [10, 30, 45, 60, 75],
		"Level": 0,
		"Value": [0.45, 0.40, 0.35, 0.30, 0.25]
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
		"Value": [999, 999, 999, 999, 999]
	}, 
	7: {
		"Name": "Magic Potion",
		"Detail": "HP max heal up",
		"Cost": [10, 30, 50, 70, 200],
		"Level": 0,
		"Value": [5, 10, 15, 20, 35]
	}
}

func _process(delta: float) -> void:
	money_label.text = "[wave]"+str(money)+"$"

func AddMoney(amount:int):
	money += amount
