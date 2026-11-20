extends Control

func _ready() -> void:
	var start_position := position
	var tween := create_tween().set_loops()
	tween.tween_property(self, "position", start_position + Vector2(0.0, -3.0), 3.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", start_position, 4.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
