extends RichTextLabel

func _ready():
	self.self_modulate.a = 0.0
	fade_in_then_out()

func fade_in_then_out():
	var tween = create_tween()
	tween.tween_property(self, "self_modulate:a", 1.0, 1.0)
	tween.tween_interval(1.0)
	tween.tween_property(self, "self_modulate:a", 0.0, 1.0)
