extends Node

var start_time : int
var elapsed_time : int

func _ready():
	start_time = Time.get_ticks_msec()

func _process(delta):
	elapsed_time = Time.get_ticks_msec() - start_time
	var minutes = int(elapsed_time / 60000)
	var seconds = int((elapsed_time % 60000) / 1000)
	var time_display = "%02d:%02d" % [minutes, seconds]
	$"../CanvasLayer/Game Over Screen/CanvasLayer/PlayTime".text = "time alive: " + time_display
