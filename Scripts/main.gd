extends Node2D

var tutorial: bool = false

func _ready():
	var config = ConfigFile.new()
	var error = config.load("user://save.cfg")
	tutorial = config.get_value("progress", "tutorial_seen", false)
	
	if !tutorial:
		config.set_value("progress", "tutorial_seen", true)
		config.save("user://save.cfg")
