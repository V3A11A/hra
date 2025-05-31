extends RichTextLabel

func _ready() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE

func fade_in():
	self.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)

func fade_out():
	self.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
