extends Control

@onready var play: Button = %Play
@onready var settings: Button = %Settings
@onready var credits: Button = %Credits
@onready var black: ColorRect = %Black
@onready var quit: Button = %Quit
@onready var button_sound: AudioStreamPlayer = %ButtonSound

func _ready() -> void:
	_fade_in()
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	credits.pressed.connect(_on_credits_pressed)	
	quit.pressed.connect(_on_quit_pressed)
	
func _fade_in() -> void:
	var tween := create_tween()
	tween.tween_property(black, "modulate:a", 0.0, 3.0)

func _on_play_pressed() -> void:
	GameManager.go_to_level_select()

func _on_settings_pressed() -> void:
	GameManager.go_to_settings()

func _on_credits_pressed() -> void:
	GameManager.go_to_credits()

func _on_quit_pressed() -> void:
	get_tree().quit()
