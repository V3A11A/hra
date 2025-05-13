extends Node
var money:int = 10

func _process(delta: float) -> void:
	$Money.text = "Money: "+str(money)
	
func AddMoney(amount:int):
	money += 2
