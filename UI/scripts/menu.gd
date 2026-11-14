extends Control

@onready var play: Button = %Play
@onready var settings: Button = %Settings
@onready var credits: Button = %Credits
@onready var black: ColorRect = %Black

func _ready() -> void:
	_fade_in()
	play.pressed.connect(GameManager.go_to_level_select)
	settings.pressed.connect(GameManager.go_to_settings)
	credits.pressed.connect(GameManager.go_to_credits)	
	
func _fade_in() -> void:
	var tween := create_tween()
	tween.tween_property(black, "modulate:a", 0.0, 3.0)
