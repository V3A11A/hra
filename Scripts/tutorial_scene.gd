extends Node2D

@onready var canvas_layer: CanvasLayer = $"../../Game/Player/EconomySystem/CanvasLayer"
@onready var hpbar: CanvasLayer = $"../../Game/Player/UI"

func _on_next_button_pressed() -> void:
	if !$"../MainMenu".inMenu:
		$"../MainMenu".process_mode = Node.PROCESS_MODE_DISABLED
		$"../MainMenu".hide()
		self.hide()
		$"../..".tutorial = true
		$"../../Game".show()
		$"../../Game".process_mode = Node.PROCESS_MODE_INHERIT
		canvas_layer.show()
		hpbar.show()
		$"../MainMenu".inMenu = false
		$"../../AudioManager".crossfire()
		$"../EscapeMenu".inGame = true
	else:
		self.hide()
	
