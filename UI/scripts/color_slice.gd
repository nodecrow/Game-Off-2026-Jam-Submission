extends TextureRect
class_name ColorSlice

@export var hue: Palette.Hue

func set_highlight(on: bool) -> void:
	var tween := create_tween()
	if on:
		tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.1)
	else:
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
