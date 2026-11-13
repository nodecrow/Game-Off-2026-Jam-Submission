extends CanvasLayer

@onready var background: ColorRect = %Background
@onready var next_level_button: Button = %NextLevelButton
@onready var level_select_button: Button = %LevelSelectButton
@onready var control: Control = %Control

func _ready() -> void:
	next_level_button.pressed.connect(_on_next_level_button_pressed)
	level_select_button.pressed.connect(_on_level_select_pressed)
	fade_in()

func fade_in() -> void:
	var tween := create_tween()
	control.modulate.a = 0
	background.modulate.a = 0
	tween.parallel()
	tween.tween_property(control, "modulate:a", 1.0, 2.0)
	tween.tween_property(background, "modulate:a", 0.5, 2.0)

func _on_next_level_button_pressed() -> void:
	GameManager.start_level(GameManager.current_level + 1)
	self.queue_free()

func _on_level_select_pressed() -> void:
	GameManager.go_to_level_select()
	self.queue_free()
