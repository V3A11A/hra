extends Node

#TODO:
	#killing enemies
	#if all enemies are spawned AND are all killed, immediately start next wave

@export var spawn_probability : Curve


##difficulty : preload("path/to/enemy.tscn")
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



@onready var enemy_spawn_CD: Timer = $"Enemy Spawn CD"
@onready var next_horde_CD: Timer = $"Next Horde CD"
@onready var next_wave_CD: Timer = $"Next Wave CD"




var wave : int = 0
var difficulty : int = 10 #change to 1
##Difficulties prefer average enemies, so no matter if difficulty is high or low, count of enemies won't be high
var wave_size_multiplier : float = 1
var hordes_in_wave : float = 2

##Array of Enemy_List keys, remaining to be spawned in given wave
var enemies_to_spawn_in_current_wave : Array[int]
##Number of enemies each horde will have this wave
var enemies_in_horde : int = 0:
	set(value):
		enemies_in_horde = maxi(value, 1)
##Array of Enemy_List keys, remaining alive in a given wave
var enemies_left_in_wave : Array[int]



func Begin_Game() -> void:
	next_wave_CD.start()
	Start_Next_Wave()



func Start_Next_Wave() -> void:
	Stop_Timers()
	Increment_Difficulty()
	#print()
	#printerr("wave:\t", wave)
	#printerr("to spawn from previous:\t", enemies_to_spawn_in_current_wave)
	Assign_Enemies_In_Current_Wave()
	enemies_in_horde = roundi(enemies_to_spawn_in_current_wave.size() / hordes_in_wave)
	#printerr("to spawn:\t", enemies_to_spawn_in_current_wave)
	#print(enemies_in_horde, " to spawn each horde")
	Spawn_Next_Horde()



func Stop_Timers() -> void:
	next_horde_CD.stop()
	enemy_spawn_CD.stop()



func Increment_Difficulty() -> void:
	wave += 1
	#difficulty += 10
	wave_size_multiplier += 0.2
	hordes_in_wave += 0.1



func Assign_Enemies_In_Current_Wave() -> void:
	var difficulty_copy : int = roundi(difficulty * wave_size_multiplier)
	
	while difficulty_copy != 0:
		var enemy_difficulty : int = Enemy_Closest_To(Sample_Curve()) #Randomized
		
		if difficulty_copy < enemy_difficulty:
			Assign_Remaining_Enemies(difficulty_copy) #Controlled
			break
		
		enemies_to_spawn_in_current_wave.append(enemy_difficulty)
		difficulty_copy -= enemy_difficulty



func Assign_Remaining_Enemies(difficulty : int) -> void:
	while difficulty != 0:
		for i :int in range(difficulty, 0, -1):
			
			var enemy_difficulty : int = Enemy_Closest_To(i)
			
			if enemy_difficulty <= i:
				enemies_to_spawn_in_current_wave.append(enemy_difficulty)
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



func Spawn_Next_Horde() -> void:
	var enemies_in_this_horde : int = enemies_in_horde
	
	for i : int in enemies_in_this_horde:
		if enemies_to_spawn_in_current_wave.is_empty():
			return
		
		Get_Random_Spawner().Spawn(Enemy_List[enemies_to_spawn_in_current_wave[0]].instantiate())
		enemies_left_in_wave.append(enemies_to_spawn_in_current_wave[0])
		enemies_to_spawn_in_current_wave.remove_at(0)
		enemies_in_this_horde -= 1
		
		#print("to spawn:\t", enemies_to_spawn_in_current_wave)
		#printerr("to kill:\t", enemies_left_in_wave)
		enemy_spawn_CD.start()
		await enemy_spawn_CD.timeout
	
	next_horde_CD.start()



func Get_Random_Spawner() -> Node:
	return get_tree().get_nodes_in_group("Spawner").pick_random()



func _on_next_horde_cd_timeout() -> void:
	Spawn_Next_Horde()

func _on_next_wave_cd_timeout() -> void:
	Start_Next_Wave()




#TEST
func _ready() -> void:
	await get_tree().physics_frame
	Begin_Game()
