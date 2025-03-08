extends Node

@export var spawn_probability : Curve


##difficulty : preload("path/to/scene")
const Enemy_List : Dictionary = {
	1 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	2 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	3 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	4 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	5 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	6 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	7 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	8 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	9 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
	10 : preload("res://Scenes/Enemy System/Enemies/Enemy.tscn"),
}



var wave : int = 0
var difficulty : int = 10

##Array of Enemy_List keys, remaining to be spawned in given wave
var enemies_left_in_current_wave : Array[int]



func Start_Next_Wave() -> void:
	wave += 1
	Assign_Enemies_In_Current_Wave()



func Assign_Enemies_In_Current_Wave() -> void:
	var difficulty_copy : int = difficulty
	
	while difficulty_copy != 0:
		var enemy_difficulty : int = Enemy_Closest_To(Sample_Curve()) #Randomized
		
		if difficulty_copy < enemy_difficulty:
			Assign_Remaining_Enemies(difficulty_copy) #Controlled
			break
		
		enemies_left_in_current_wave.append(enemy_difficulty)
		difficulty_copy -= enemy_difficulty



func Assign_Remaining_Enemies(difficulty : int) -> void:
	while difficulty != 0:
		for i :int in range(difficulty, 0, -1):
			
			var enemy_difficulty : int = Enemy_Closest_To(i)
			
			if enemy_difficulty <= i:
				enemies_left_in_current_wave.append(enemy_difficulty)
				difficulty -= enemy_difficulty
				break



##Returns the closest key of Enemy_List to difficulty
func Enemy_Closest_To(difficulty : int) -> int:
	var closest : int = Enemy_List.keys()[0]
	var closest_distance : int = absi(closest - difficulty)
	
	
	for i : int in Enemy_List.keys():
		if i == difficulty:
			return i
		
		var temp_distance : int = absi(i - difficulty)
		
		if temp_distance < closest_distance:
			closest = i
			closest_distance = temp_distance
		
	return closest




func Sample_Curve() -> int:
	return roundi(spawn_probability.sample_baked(randf()) * difficulty)


func _ready() -> void:
	for i in 100:
		Start_Next_Wave()
		print(enemies_left_in_current_wave)
		enemies_left_in_current_wave = []
