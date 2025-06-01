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
		"Cost": [50, 100, 150, 200, 300],
		"Level": 0,
		"Value": [1.30, 1.60, 1.90, 2.20, 2.50]
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
		"Cost": [10, 30, 45, 60, 75],
		"Level": 0,
		"Value": [2.4, 2.8, 3.2, 3.6, 4]
	}, 
	4: {
		"Name": "Gun",
		"Detail": "Firerate up",
		"Cost": [20, 35, 50, 65, 80],
		"Level": 0,
		"Value": [0.18, 0.16, 0.14, 0.12, 0.1]
	}, 
	5: {
		"Name": "Boots",
		"Detail": "Movement speed up",
		"Cost": [50, 90, 125, 165, 200],
		"Level": 0,
		"Value": [1.1, 1.2, 1.3, 1.4, 1.5]
	}, 
	6: {
		"Name": "healthUP! drink",
		"Detail": "HP heal",
		"Cost": [10, 15, 20, 25, 30, 35, 40, 45, 50, 55],
		"Level": 0,
		"Value": [999, 999, 999, 999, 999, 999, 999, 999, 999, 999]
	}, 
	7: {
		"Name": "Mysterious\n\n\nSyringe",
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
