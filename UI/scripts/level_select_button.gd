extends Button

var level: int = 0
var is_unlocked: bool = false

func _ready() -> void:
	offset_transform_enabled = true
	offset_transform_pivot_ratio = Vector2(0.5, 0.5)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	self.pressed.connect(_on_mouse_pressed)
	level = get_index()
	text = str(level + 1)
	disabled = GameManager.is_level_unlocked(level)

func _pressed() -> void:
		GameManager.start_level(level)


func _on_mouse_entered() -> void:
	var tween := create_tween()
	tween.tween_property(self, "offset_transform_scale", Vector2(1.1, 1.1), 0.2)
	AudioPlayer.play_button_hover()

func _on_mouse_exited() -> void:
	var tween := create_tween()
	tween.tween_property(self, "offset_transform_scale", Vector2(1.0, 1.0), 0.2)

func _on_mouse_pressed() -> void:
	AudioPlayer.play_button_click()
