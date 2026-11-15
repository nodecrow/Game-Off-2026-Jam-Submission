extends Control

@onready var play_button: JuicyButton = %PlayButton
@onready var settings_button: JuicyButton = %SettingsButton
@onready var credits_button: JuicyButton = %CreditsButton
@onready var quit_button: JuicyButton = %QuitButton
@onready var black: ColorRect = %Black

@onready var settings: CanvasLayer = %Settings

func _ready() -> void:
	settings.hide()
	_fade_in()
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	credits_button.pressed.connect(_on_credits_pressed)	
	quit_button.pressed.connect(_on_quit_pressed)
	
	settings.closed.connect(_on_settings_closed)
	
func _fade_in() -> void:
	var tween := create_tween()
	tween.tween_property(black, "modulate:a", 0.0, 3.0)

func _on_play_pressed() -> void:
	GameManager.go_to_level_select()

func _on_settings_pressed() -> void:
	self.hide()
	settings.show()

func _on_credits_pressed() -> void:
	GameManager.go_to_credits()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_closed() -> void:
	self.show()
	settings.hide()
