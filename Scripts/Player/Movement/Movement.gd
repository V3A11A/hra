extends CollisionShape2D


@onready var player : CharacterBody2D = $".."
@onready var drag_area_detector : Area2D = $"Drag Area Detector"
@onready var run : Node = $Run



var final_speed : Vector2


var run_velocity : Vector2

func _physics_process(delta: float) -> void:
	run_velocity = run.Update(delta)
	
	player.velocity = Calculate()
	player.move_and_slide()
	
	previous_facing_direction = facing_direction



func Calculate() -> Vector2:
	return run_velocity




var just_pressed_left : bool
var pressed_left : bool
var just_released_left : bool

var just_pressed_right : bool
var pressed_right : bool
var just_released_right : bool

var just_pressed_up : bool
var pressed_up : bool
var just_released_up : bool

var just_pressed_down : bool
var pressed_down : bool
var just_released_down : bool

##Wheather the player pressed [b]BOTH[/b] Left and Right input keys in the same frame.[br]
var indecisive : Vector2i
var facing_direction : Vector2i = Vector2i.ONE ##1 is down/right, -1 is up/left. 0 is invalid.
var previous_facing_direction : Vector2i = facing_direction

func _unhandled_key_input(_event: InputEvent) -> void:
	just_pressed_left = Input.is_action_just_pressed("Left")
	pressed_left = Input.is_action_pressed("Left")
	just_released_left = Input.is_action_just_released("Left")
	
	just_pressed_right = Input.is_action_just_pressed("Right")
	pressed_right = Input.is_action_pressed("Right")
	just_released_right = Input.is_action_just_released("Right")
	
	just_pressed_up = Input.is_action_just_pressed("Up")
	pressed_up = Input.is_action_pressed("Up")
	just_released_up = Input.is_action_just_released("Up")
	
	just_pressed_down = Input.is_action_just_pressed("Down")
	pressed_down = Input.is_action_pressed("Down")
	just_released_down = Input.is_action_just_released("Down")
	
	
	
	if just_pressed_left and just_pressed_right:
		indecisive.x = true
		return
	if just_pressed_up and just_pressed_down:
		indecisive.y = true
		return
	
	
	
	if just_pressed_left:
		facing_direction.x = -1
	elif just_pressed_right:
		facing_direction.x = 1
	if just_pressed_up:
		facing_direction.y = -1
	elif just_pressed_down:
		facing_direction.y = 1
	
	
	
	if just_released_left:
		indecisive.x = false
		if pressed_right:
			facing_direction.x = 1
		else:
			facing_direction.x = -1
	if just_released_right:
		indecisive.x = false
		if pressed_left:
			facing_direction.x = -1
		else:
			facing_direction.x = 1
	if just_released_up:
		indecisive.y = false
		if pressed_down:
			facing_direction.y = 1
		else:
			facing_direction.y = -1
	if just_released_down:
		indecisive.y = false
		if pressed_up:
			facing_direction.y = -1
		else:
			facing_direction.y = 1
	
	run.Update_Inputs()



func _on_drag_area_detector_area_entered(_area : Area2D) -> void:
	Calculate_Drag(drag_area_detector.get_overlapping_areas())

func _on_drag_area_detector_area_exited(_area : Area2D) -> void:
	Calculate_Drag(drag_area_detector.get_overlapping_areas())


func Calculate_Drag(areas : Array[Area2D]) -> void:
	if areas.is_empty():
		run.drag_multiplier = 1.0
		return
	
	var drag : float = 0
	
	for area : Area2D in areas:
		if "drag" in area:
			drag += area.drag
		else:
			drag += 1.0
	
	drag /= areas.size()
	run.drag_multiplier = drag
