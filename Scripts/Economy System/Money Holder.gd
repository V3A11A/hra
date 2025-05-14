extends Node
@export var money : int

@onready var economy_system : Node = get_tree().get_root().get_node("Main/Game/Player/EconomySystem")
@onready var health_system: Node = $"../Health System"


func _on_health_system_obliterate() -> void:
	economy_system.AddMoney(money)

func _ready() -> void:
	health_system.Obliterate.connect(_on_health_system_obliterate)
