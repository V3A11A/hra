extends Node

@onready var movement : CollisionShape2D = $".."

#add: slipperiness mult

const MAX_SPEED : float = 1000
const MIN_SPEED : float = MAX_SPEED / 5
const ACCELERATION : float = MAX_SPEED * 8
const DECELERATION : float = MAX_SPEED * 20

const CHANGE_DIRECTION_MULTIPLIER : float = 1.8 ##When changing direction without releasing, gain boost
const MIN_SPEED_MARGIN : float = 50 ##If speed is this or lower when you start to run, apply min_speed



var current_max_speed : float = MAX_SPEED
var current_min_speed : float = MIN_SPEED
var current_acceleration : float = ACCELERATION
var current_deceleration : float = DECELERATION



var speed_multiplier : float = 1.5:
	set(value):
		speed_multiplier = value
		Calculate_Bonuses()

var drag_multiplier : float = 1.0:
	set(value):
		drag_multiplier = value
		Calculate_Bonuses()



var apply_direction_multiplier : bool
func Calculate_Bonuses() -> void:
	current_max_speed = MAX_SPEED * speed_multiplier
	current_min_speed = MIN_SPEED * speed_multiplier
	current_acceleration = ACCELERATION * speed_multiplier * drag_multiplier
	current_deceleration = DECELERATION * speed_multiplier * drag_multiplier
	
	if apply_direction_multiplier:
		current_acceleration *= CHANGE_DIRECTION_MULTIPLIER



var acceleration : Vector2
var decelerations : Array[Vector2]
var final_speed : Vector2

func Update(delta : float) -> Vector2:
	if not movement.indecisive.x:
		Update_Acceleration_X(delta)
	if not movement.indecisive.y:
		Update_Acceleration_Y(delta)
	Update_Decelerations(delta)
	
	Update_Final_Speed()
	final_speed *= abs(final_speed.normalized()) #corrects diagonal movement
	return final_speed



func Update_Acceleration_X(delta : float) -> void:
	if not (movement.pressed_left or movement.pressed_right):
		return
	
	if movement.pressed_left and movement.pressed_right and movement.facing_direction.x != movement.previous_facing_direction.x:
		apply_direction_multiplier = true
		Calculate_Bonuses()
	
	if acceleration.x > current_max_speed:
		acceleration.x -= current_deceleration * delta
		acceleration.x = clampf(acceleration.x, current_max_speed, acceleration.x)
	
	elif acceleration.x < -current_max_speed:
		acceleration.x += current_deceleration * delta
		acceleration.x = clampf(acceleration.x, acceleration.x, -current_max_speed)
	
	else:
		acceleration.x += movement.facing_direction.x * current_acceleration * delta
		acceleration.x = clampf(acceleration.x, -current_max_speed, current_max_speed)
	
	if apply_direction_multiplier and is_equal_approx(absf(acceleration.x), current_max_speed):
		apply_direction_multiplier = false
		Calculate_Bonuses()

func Update_Acceleration_Y(delta : float) -> void:
	if not (movement.pressed_up or movement.pressed_down):
		return
	
	if movement.pressed_up and movement.pressed_down and movement.facing_direction.y != movement.previous_facing_direction.y:
		apply_direction_multiplier = true
		Calculate_Bonuses()
	
	if acceleration.y > current_max_speed:
		acceleration.y -= current_deceleration * delta
		acceleration.y = clampf(acceleration.y, current_max_speed, acceleration.y)
	
	elif acceleration.y < -current_max_speed:
		acceleration.y += current_deceleration * delta
		acceleration.y = clampf(acceleration.y, acceleration.y, current_max_speed)
	
	else:
		acceleration.y += movement.facing_direction.y * current_acceleration * delta
		acceleration.y = clampf(acceleration.y, -current_max_speed, current_max_speed)
	
	if apply_direction_multiplier and is_equal_approx(absf(acceleration.y), current_max_speed):
		apply_direction_multiplier = false
		Calculate_Bonuses()



func Update_Decelerations(delta : float) -> void:
	#Delete decelerations that are equal to 0
	for i : int in range(decelerations.size() -1, -1, -1):
		if is_zero_approx(decelerations[i].x) and is_zero_approx(decelerations[i].y):
			decelerations.remove_at(i)
	
	
	for i : int in range(len(decelerations)):
		var dec_sign_x : float = signf(decelerations[i].x)
		decelerations[i].x -= current_deceleration * dec_sign_x * delta
		
		if is_equal_approx(dec_sign_x, 1):
			decelerations[i].x = clampf(decelerations[i].x, 0, decelerations[i].x)
		else:
			decelerations[i].x = clampf(decelerations[i].x, decelerations[i].x, 0)
		
		
		var dec_sign_y : float = signf(decelerations[i].y)
		decelerations[i].y -= current_deceleration * dec_sign_y * delta
		
		if is_equal_approx(dec_sign_y, 1):
			decelerations[i].y = clampf(decelerations[i].y, 0, decelerations[i].y)
			return
		decelerations[i].y = clampf(decelerations[i].y, decelerations[i].y, 0)



func Update_Final_Speed() -> void:
	final_speed = acceleration
	for i : Vector2 in decelerations:
		final_speed += i



func Update_Inputs() -> void:
	if movement.indecisive.x:
		Change_Acceleration_To_Deceleration(true, false)
	if movement.indecisive.y:
		Change_Acceleration_To_Deceleration(false)
	
	
	if not is_zero_approx(drag_multiplier):
		Check_For_Minimum_Speed_X()
		Check_For_Minimum_Speed_Y()
	Check_For_Release()



func Change_Acceleration_To_Deceleration(x : bool = true, y : bool = true) -> void:
	if x and y:
		decelerations.append(acceleration)
		acceleration = Vector2.ZERO
	elif x:
		decelerations.append(Vector2(acceleration.x, 0))
		acceleration.x = 0
	elif y:
		decelerations.append(Vector2(0, acceleration.y))
		acceleration.y = 0



func Check_For_Minimum_Speed_X() -> void:
	if movement.indecisive.x:
		return
	if absf(final_speed.x) > MIN_SPEED_MARGIN or is_equal_approx(absf(final_speed.x), MIN_SPEED_MARGIN):
		return
	
	if movement.just_pressed_left:
		if acceleration.x > -current_min_speed:
			acceleration.x -= current_min_speed
	if movement.just_pressed_right:
		if acceleration.x < current_min_speed:
			acceleration.x += current_min_speed

func Check_For_Minimum_Speed_Y() -> void:
	if movement.indecisive.y:
		return
	if absf(final_speed.y) > MIN_SPEED_MARGIN or is_equal_approx(absf(final_speed.y), MIN_SPEED_MARGIN):
		return
	
	if movement.just_pressed_up:
		if acceleration.y > -current_min_speed:
			acceleration.y -= current_min_speed
	if movement.just_pressed_down:
		if acceleration.y < current_min_speed:
			acceleration.y += current_min_speed



func Check_For_Release() -> void:
	var new_deceleration : Vector2 = Vector2.ZERO
	
	if movement.just_released_left:
		if movement.pressed_right:
			if acceleration.x < 0:
				apply_direction_multiplier = true
				Calculate_Bonuses()
		else:
			new_deceleration.x = acceleration.x
	
	elif movement.just_released_right:
		if movement.pressed_left:
			if acceleration.x > 0:
				apply_direction_multiplier = true
				Calculate_Bonuses()
		else:
			new_deceleration.x = acceleration.x
	
	if movement.just_released_up:
		if movement.pressed_down:
			if acceleration.y < 0:
				apply_direction_multiplier = true
				Calculate_Bonuses()
		else:
			new_deceleration.y = acceleration.y
	
	elif movement.just_released_down:
		if movement.pressed_up:
			if acceleration.y > 0:
				apply_direction_multiplier = true
				Calculate_Bonuses()
		else:
			new_deceleration.y = acceleration.y
	
	
	if new_deceleration == Vector2.ZERO:
		return
	decelerations.append(new_deceleration)
	acceleration -= new_deceleration


##Initial update
func _ready() -> void:
	Calculate_Bonuses()
