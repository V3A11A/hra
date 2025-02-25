extends Node

var randomIntensity: float = 0 # Jak moc se bude obrazovka hýbat + předem specifikování
var shakeTime: float = 0 # Jak dlouho se bude shakeovat + předem specifikování

var rng = RandomNumberGenerator.new()
var shakeIntensity: float = 0.0 # Intenzita, předem specifikovaná

func apply_shake(moveTime, intensity): # moveTime -> čím vyšší tím kratší doba, intensity -> čím větší tím více třesu
	shakeTime = moveTime
	randomIntensity = intensity
	shakeIntensity = randomIntensity

func _process(delta: float) -> void:
	if shakeIntensity > 0:
		shakeIntensity = lerpf(shakeIntensity, 0, shakeTime * delta) # Třesání kamery od intenzity do 0,po dobu času
	$Player/Camera2D.offset = randomOffset() # Nastavení offsetu u kamery

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeIntensity, shakeIntensity), 0) # Random pohyb
