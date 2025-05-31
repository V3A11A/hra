extends Camera2D

var shakeIntensity: float # určení intenzity
var shakeTime: float # čas trvání
var allowShake: bool = true # jestli je povoleno v nastavení (defaultně povoleno)
var rng = RandomNumberGenerator.new() # náhodná generace čísel

# funkce na aplikování času a intenzity
func apply_shake(time, intensity):
	shakeTime = time
	shakeIntensity = intensity

# funkce se volá každý snímek
func _process(delta: float) -> void:
	if !allowShake: return
	if shakeIntensity > 0:
		shakeIntensity = lerpf(shakeIntensity, 0, shakeTime * delta) # postupné klesání do 0
	offset = randomOffset() # náhodně přenese kameru

# funkce generuje Vektor odsazení kamery
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeIntensity, shakeIntensity), rng.randf_range(-shakeIntensity, shakeIntensity))
